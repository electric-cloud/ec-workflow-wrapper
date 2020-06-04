package Setup;
use strict;
use warnings;
use JSON;
use Data::Dumper;
use Digest::MD5;
use MIME::Base64 qw(decode_base64);
use Archive::Zip;
use ElectricCommander::Util;
use ElectricCommander;
use File::Find;
use File::Spec;
use File::Path qw(mkpath);
use File::Temp q(tempfile);
use File::Copy::Recursive qw(rcopy);

$|++;

use constant {
    META_PROPERTY => '/myProject/ec_binary_dependencies',
    DEPS_CACHE => "depsCache",
    SHARED_DEPENDENCIES_PATH => 'sharedDependenciesPath',
};

sub logInfo {
    my @messages = @_;

    for my $m (@messages) {
        if (ref $m) {
            print Dumper $m;
        }
        else {
            print "$m\n";
        }
    }
}

sub logError {
    my @messages = @_;

    for my $m (@messages) {
        if (ref $m) {
            print "[ERROR] " . Dumper $m;
        }
        else {
            print "[ERROR] $m\n";
        }
    }
}

sub new {
    my ($class) = @_;
    return bless {}, $class;
}


sub fetchFromServer {
    my ($self, $dest) = @_;

    # REST Client
    my $ec = ElectricCommander->new;
    my $session = $ENV{COMMANDER_SESSIONID};
    my $ua = LWP::UserAgent->new(
        conn_cache => new LWP::ConnCache( total_capacity => 100 ),
        cookie_jar => {},
        timeout => $ec->{timeout},
        ssl_opts => { verify_hostname => 0 }
    );

    my $httpProxy = $ENV{COMMANDER_HTTP_PROXY};
    if ($httpProxy && $ElectricCommander::VERSION >= 9.0000) {
        # Because prior 9.0, the proxy didn't work with rest calls
        # $ua->proxy(https => $httpProxy);
        # $ua->proxy(http => $httpProxy);
    }

    my $protocol = $ENV{COMMANDER_SECURE} ? 'https' : 'http';
    my $httpsPort = $ENV{COMMANDER_HTTPS_PORT} || 8443;
    my $httpPort = $ENV{COMMANDER_PORT} || 8000;
    my $port = $ENV{COMMANDER_SECURE} ? $httpsPort : $httpPort;
    my $server = $ENV{COMMANDER_SERVER} || 'localhost';
    my $pluginName = '@PLUGIN_NAME@';
    my $url = "$protocol://$server:$port/rest/v1.0/plugins/$pluginName/agent-dependencies";

    my ($fh, $dependencies) = tempfile("dependenciesXXXXX",
        DIR => $dest,
        CLEANUP => 1,
        SUFFIX => '.zip',
    );

    my $response;
    eval {
        $response = $ua->get($url,
            cookie => "sessionId=$session",
            ':content_file' => $dependencies
        );
        1;
    } or do {
        logError("Failed to retrieve dependencies from the server: $@");
    };
    unless($response->is_success) {
        logError "Failed to retrieve dependencies from the server: code " . $response->code . ", status: " . $response->status_line . ", message: " . $response->content;
        die "Failed to retrieve dependencies from the server: " . $response->code;
    }

    logInfo "Saved response to $dependencies";
    return $dependencies;
}


sub fetchFromDsl {
    my ($self, $dest) = @_;

    my $ec = ElectricCommander->new;
    my $dsl = $ec->getPropertyValue('/myProcedure/ec_compressAndDeliver');

    my $hasMore = 1;
    my $offset = 0;

    my ($fh, $dependencies) = tempfile("dependenciesXXXXX",
        DIR => $dest,
        CLEANUP => 1,
        SUFFIX => '.zip',
    );
    binmode $fh;
    my $source = $ec->getPropertyValue('/server/settings/pluginsDirectory') .'/@PLUGIN_NAME@/agent';
    while($hasMore) {
        my $args = {
            offset => $offset,
            source => $source,
            chunkSize => 1024 * 1024 * 4
        };
        print "Calling evalDSl with arguments " . Dumper ($args) . "\n";
        my $xpath = $self->ec->evalDsl({
            dsl => $dsl,
            parameters => encode_json($args),
        });
        my $result = $xpath->findvalue('//value')->string_value;
        my $chunks = decode_json($result);
        my $chunk = $chunks->{chunk};
        my $bytes = decode_base64($chunk);
        my $remaining = $chunks->{remaining};
        print "Got bytes: " . length($bytes) . "\n";
        print "Bytes remaining: " . $remaining . "\n";
        my $readBytes = $chunks->{readBytes};
        $offset += $readBytes;
        print "Read bytes: $readBytes\n";
        if ($readBytes > 0) {
            print $fh $bytes;
        }
        if ($remaining == 0 || $readBytes <= 0) {
            $hasMore = 0;
        }
    }

    close $fh;
    return $dependencies;
}


sub setupParentPlugins {
    my ($self, $pluginsList) = @_;

    for my $plugin (split(/\s+/ => $pluginsList)) {
        logInfo "Found external plugin dependency: $plugin";

        # my $jobId = $self->ec()->runProcedure({
        #     projectName => "/plugins/$plugin/project",
        #     procedureName => "flowpdk-setup",
        #     resourceName => '$[resourceName]'
        # })->findvalue('//jobId')->string_value;

        my $jobStepId = $self->ec->createJobStep({
            subproject => "/plugins/$plugin/project",
            subprocedure => 'flowpdk-setup',
            resourceName => '$[resourceName]',
            errorHandling => 'failProcedure',
            stepName => "$plugin setup"
        })->findvalue('//jobStepId');

        logInfo "Launched setup job step for the plugin $plugin, jobStepId: $jobStepId";

        my $status = $self->ec()->getJobStepStatus({
            jobStepId => $jobStepId
        });

        logInfo "Waiting for the setup job step...";

        while($status->findvalue('//status') ne 'completed') {
            sleep 5;
            $status = $self->ec()->getJobStepStatus($jobStepId);
        }
    }
}

sub isLocalResource {
    my ($self) = @_;

    my $file = File::Spec->catfile($ENV{COMMANDER_PLUGINS}, '@PLUGIN_NAME@/META-INF');
    if (-d $file) {
        logInfo "Working on local resource";
        return 1;
    }
    return 0;
}

# Auto-generated method for the procedure DeliverDependencies/DeliverDependencies
# Add your code into this method and it will be called when step runs
sub deliverDependencies {
    my ($self) = @_;

    my $resName = '$[/myResource/name]';
    $self->ec->setProperty('/myJob/grabbedResource', $resName);
    $self->ec->setProperty('/myJobStep/parent/flowpdkResource', $resName);
    $self->ec->setProperty('/myJob/flowpdkResource', $resName);

    my $dependsOnPlugins = eval {
        $self->ec->getPropertyValue('dependsOnPlugins')
    };
    if ($dependsOnPlugins) {
        $self->setupParentPlugins($dependsOnPlugins);
    }
    my $dest = File::Spec->catfile($ENV{COMMANDER_PLUGINS}, '@PLUGIN_NAME@/agent');

    logInfo "Grabbed resource $resName";

    if ($self->checkCache() || $self->isLocalResource()) {
        print "Local file cache is ok\n";
        $self->copyGrapes();
        $self->copySharedDeps();
        $self->configureClasspath();
        exit 0;
    }

    logInfo "Local cache failed, reloading files";

    my $source = $self->ec->getPropertyValue('/server/settings/pluginsDirectory') .'/@PLUGIN_NAME@/agent';
    logInfo "Fetching dependencies from $source";
    mkpath($dest);

    my $dependencies;

    my $serverVersion = $self->ec()->getVersions()->findvalue('//serverVersion/version')->string_value;
    logInfo "Server version is $serverVersion";
    if (compareMinor($serverVersion, '9.3') >= 0) {
        $dependencies = $self->fetchFromServer($dest);
    }
    else {
        $dependencies = $self->fetchFromDsl($dest);
    }

    my $zip = Archive::Zip->new();
    logInfo "Reading .zip file $dependencies";
    unless($zip->read($dependencies) == Archive::Zip::AZ_OK()) {
      die "Cannot read .zip dependencies: $!";
    }
    $zip->extractTree("", $dest . '/');

    # Check if not empty
    # Just in case
    opendir my $dh, $dest or die "Cannot open directory $dest: $!";
    my @files = grep { $_ !~ /^\./ } readdir $dh;
    unless(scalar @files) {
        logError "No files found in the $dest directory, it is probably corrupted", "Please check the folder $source/@PLUGIN_NAME@/agent on the Flow Server filesystem. If it is empty, please reinstall the plugin.";
        die "No files found in the $dest directory. It is probably corrupted";
    }

    unlink $dependencies;
    print "Extracted dependencies archive\n";
    $self->writeMeta();

    $self->copyGrapes();
    $self->copySharedDeps();
    $self->configureClasspath();
}

sub configureClasspath {
    my ($self) = @_;

    # Now configuring classpath
    my $generateClasspathFromFolders = eval {
        $self->ec->getPropertyValue('generateClasspathFromFolders')
    };
    return unless $generateClasspathFromFolders;

    logInfo "generateClasspathFromFolders: $generateClasspathFromFolders";
    # Folders are relative to agent/ folder
    my @jars = ();

    for my $folder (split /\,\s*/ => $generateClasspathFromFolders) {
        my $path = File::Spec->catfile($ENV{COMMANDER_PLUGINS}, '@PLUGIN_NAME@/agent/' . $folder);
        if (-d $path) {
            my $libPath = File::Spec->catfile($path, "*");
            logInfo "Adding folder $libPath to classpath";
            push @jars, $libPath;
        }
        else {
            logInfo "The path $path is not a directory";
        }
    }

    my $os = $^O;
    my $separator = ':';
    if ($os =~ /win/i) {
        $separator = ";";
    }
    my $classpath = join($separator, @jars);
    unless($classpath) {
        die "Failed to generate classpath: classpath is empty.";
    }
    $self->ec->setProperty({propertyName => '/myJob/flowpdk_classpath', value => qq{"$classpath"}});
    logInfo "Classpath: $classpath\n";

}

sub copyGrapes {
    my ($self) = @_;

    my $grapes = File::Spec->catfile(
        $ENV{COMMANDER_PLUGINS},
        '@PLUGIN_NAME@/agent/grape'
    );

    unless(-d $grapes) {
        return;
    }

    logInfo "Grapes folder found";
    my $grapesDir = $ENV{COMMANDER_DATA} . '/grape';
    mkpath($grapesDir);
    rcopy($grapes, $grapesDir);
    logInfo "Copied grapes dependencies into $grapesDir";
}

sub copySharedDeps {
    my ($self) = @_;

    my $sharedDeps = File::Spec->catfile(
        $ENV{COMMANDER_PLUGINS},
        '@PLUGIN_NAME@/agent/shared'
    );

    unless(-d $sharedDeps) {
        return;
    }

    my $destFolder = eval {
        $self->ec->getPropertyValue(META_PROPERTY . '/sharedDependenciesPath');
    };
    $destFolder ||= 'shared-deps';

    my $destination = File::Spec->catfile($ENV{COMMANDER_DATA}, $destFolder);
    rcopy($sharedDeps, $destination);
    logInfo "Shared dependencies copied into $destination";
}

sub checkCache {
    my ($self) = @_;

    my $prop = META_PROPERTY . '/' . DEPS_CACHE;
    my $meta;
    eval {
        my $metaJson = $self->ec->getPropertyValue($prop);
        $meta = JSON->new->decode($metaJson);
        1;
    } or do {
        logInfo "Cannot read dependencies map $prop";
        return 0;
    };
    my $folder = File::Spec->catfile($ENV{COMMANDER_PLUGINS}, '@PLUGIN_NAME@/agent');
    for my $file (keys %$meta) {
        my $fullname = File::Spec->catfile($folder, $file);
        if (!-f $fullname) {
            logInfo "Cannot find file $fullname declared in the cache map";
            return 0;
        }
    }
    return 1;
}

sub writeMeta {
    my ($self) = @_;
    my $folder = File::Spec->catfile($ENV{COMMANDER_PLUGINS}, '@PLUGIN_NAME@/agent');
    my %files = ();
    find(sub {
        return if $_ =~ /^\./;
        return if -d $File::Find::name;
        my $rel = File::Spec->abs2rel($File::Find::name, $folder);
        $files{$rel} = -1;
    }, $folder);

    my $meta = JSON->new->encode(\%files);
    my $property = META_PROPERTY . '/' . DEPS_CACHE;
    $self->ec->setProperty($property, $meta);
    logInfo "Saved meta into $property", \%files;
}

sub ec {
    my ($self) = @_;

    $self->{ec} ||= ElectricCommander->new;
    return $self->{ec};
}


sub getSharedDepsFolder {
    my ($self) = @_;

    my $destFolder = eval {
        $self->ec->getPropertyValue(META_PROPERTY . '/' . SHARED_DEPENDENCIES_PATH);
    };
    $destFolder ||= 'shared-deps';

    my $destination = File::Spec->catfile($ENV{COMMANDER_DATA}, $destFolder);
    return $destination;
}


1;


my $o = Setup->new;
$o->deliverDependencies();

