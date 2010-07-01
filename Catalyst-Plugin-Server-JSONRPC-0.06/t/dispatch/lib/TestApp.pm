### Dispatch based jsonrpc server ###
package TestApp;

use strict;
use Catalyst qw[Server Server::JSONRPC];
use base qw[Catalyst];

our $VERSION = '0.01';

### XXX make config configurable, so we can test the jsonrpc 
### specific config settings
TestApp->config( 
);

TestApp->setup;

### accept every jsonrpc request here
sub my_dispatcher : JSONRPCRegex('.') {
    my( $self, $c ) = @_;
    ### return the name of the method you called    
    $c->stash->{'jsonrpc'} = $c->request->jsonrpc->method;
}

1;
