::

   Below are located Pure Perl dependencies for RSA signing.
    * Crypt::Perl::RSA with non-core dependecies
    * Math::BigInt (v1.999811).

    This Math::BigInt version should be included because some methods (e.g. bge() and bne() are not implemented in EC package)

    Modifications for original files:
     - Removed all library files from Crypt::Perl that was not required (simply deleted files one by one with a simple script)
     - Concatenated everything (except Bytes::Random::Secure::Tiny) to a single file
     - All 'use' are replaced with ->import() (because everything is located in a single file)
     - Added sign_RS1() signing method to Crypt::Perl::RSA::PrivateKey
     - Math::BigInt::Calc method api_version() was changed to _api_version() with corresponding places it was used
     - Patched Crypt::Format der2pem with string below to support keys passed without newlines
           $pem=~s<\s?-{5}(?:BEGIN|END)\s[A-Z\s]+-{5}\s?><>s;
     - Changed non-ASCII symbols (probably got there because of copying the code from browser's window)

    All concatenated modules was "packed" with
      $ perltidy -b -dp -dac --mangle dsl/properties/lib/EC/OAuthDependencies/RSA.pm

