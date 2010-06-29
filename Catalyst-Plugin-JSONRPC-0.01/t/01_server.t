use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/lib";

use Test::More;
use Catalyst::Test 'TestApp';
use JSON ();

BEGIN {
    no warnings 'redefine';

    *Catalyst::Test::local_request = sub {
        my ( $class, $request ) = @_;

        require HTTP::Request::AsCGI;
        my $cgi = HTTP::Request::AsCGI->new( $request, %ENV )->setup;

        $class->handle_request;

        return $cgi->restore->response;
    };
}

my $entrypoint = 'http://localhost/rpc';

run_tests();

done_testing;

sub run_tests {

    # test echo
    test_xmlrpc({ method => 'echo', params => [ 'hello' ], id => 1 },
                { error => undef, id => 1, result => 'hello' }
    );
    # test add
    test_xmlrpc({ method => 'add', params => [ 1, 2 ], id => 2 }, 
                { error => undef, id => 2, result => 3 }
    );
}

sub test_xmlrpc {
  my ($params, $expected_return) = @_;
  my $content = JSON::to_json($params);
  my $request = HTTP::Request->new( POST => $entrypoint );
  $request->header( 'Content-Length' => length($content) );
  $request->header( 'Content-Type'   => 'text/xml' );
  $request->content($content);

  ok( my $response = request($request), 'Request' );
  ok( $response->is_success, 'Response Successful 2xx' );
  is( $response->code, 200, 'Response Code' );

  my $json_expected = JSON::to_json($expected_return);
  # If the below test fails it can be because the Catalyst app may not be serializing
  # with the same JSON module...
  is( $response->content, $json_expected, 'Content OK' );
  my $got = JSON::from_json($response->content);
  is_deeply($got, $expected_return, 'Returned datastructure OK');
}
