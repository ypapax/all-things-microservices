#!/bin/bash
set -ex

curl1(){
  grpcurl --plaintext localhost:9092 list # plaintext means no tls
#  Currency
#  grpc.reflection.v1alpha.ServerReflection
}

#reflection is on https://youtu.be/RHWwMrR8LUs?t=538
# if it's not on we need to point to proto file for grpcurl

curl2(){
  grpcurl -import-path grpc-curl/protos -proto service.proto list
#  Currency
}

curl3(){
  grpcurl -import-path grpc-curl/protos -proto service.proto list Currency
#  Currency.GetRate
#  Currency.SubscribeRates
}

curl4(){
  grpcurl -import-path grpc-curl/protos -proto service.proto describe Currency.GetRate
#  grpcurl --paintext localhost:9092 describe Currency.GetRate # not working
#  Currency.GetRate is a method:
#  // GetRate returns the exchange rate for the two provided currency codes
#  rpc GetRate ( .RateRequest ) returns ( .RateResponse );
}

curl44(){
  grpcurl -import-path grpc-curl/protos -proto service.proto describe .RateRequest
#  RateRequest is a message:
#  // RateRequest defines the request for a GetRate call
#  message RateRequest {
#    // Base is the base currency code for the rate
#    .Currencies Base = 1;
#    // Destination is the destination currency code for the rate
#    .Currencies Destination = 2;
#  }
}

curl5(){
  grpcurl -import-path grpc-curl/protos -proto service.proto -msg-template describe .RateRequest
#  RateRequest is a message:
#  // RateRequest defines the request for a GetRate call
#  message RateRequest {
#    // Base is the base currency code for the rate
#    .Currencies Base = 1;
#    // Destination is the destination currency code for the rate
#    .Currencies Destination = 2;
#  }
#
#  Message template:
#  {
#    "Base": "EUR",
#    "Destination": "EUR"
#  }
}

curl6(){
  grpcurl --plaintext -d '{
                             "Base": "EUR",
                             "Destination": "EUR"
                           }' localhost:9092 Currency/GetRate
#{
#  "rate": 23.12
#}
#https://youtu.be/RHWwMrR8LUs?t=934
}
"$@"