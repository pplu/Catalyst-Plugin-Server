use ExtUtils::MakeMaker;

print qq[

**** IMPORTANT *****

RPC::XML 0.69 has introduced a backwards incompatible change!!!

This module will currently only work with RPC::XML 0.67 or before.

I repeat, you ***MUST**** install RPC::XML 0.67 or before for this
module to work.

See this bug report for details:

  https://rt.cpan.org/Ticket/Display.html?id=50013
  
********************  
    \n];
    
sleep 3;    

WriteMakefile(
    'NAME'         => 'Catalyst::Plugin::Server',
    'VERSION_FROM' => 'lib/Catalyst/Plugin/Server.pm',
    'EXE_FILES'    => ['bin/rpc_client'],
    'PREREQ_PM'    => { 'Catalyst'          => '5.66',
                        'RPC::XML'          => '1.35',
                        'RPC::XML::Parser'  => '1.12',
                        'MRO::Compat'       => 0,
                    }
);
