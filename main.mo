import Text "mo:base/Text";
import Nat "mo:base/Nat";

// Create a simple Counter actor.
actor Counter {
  stable var currentValue : Nat = 999;

  // Increment the counter with the increment function.
  public func increment() : async () {
    currentValue += 1;
  };

  // Read the counter value with a get function.
  public query func get() : async Nat {
    currentValue
  };

  // Write an arbitrary value with a set function.
  public func set(n: Nat) : async () {
    currentValue := n;
  };

  // HTTP REQUEST
  type HttpRequest = {
    body: Blob;
    headers: [HeaderField];
    method: Text;
    url: Text;
  };

  type HttpResponse = {
    body: Blob;
    headers: [HeaderField];
    status_code: Nat16;
  };

  type HeaderField = (Text,Text );
  
  // local: http://rrkah-fqaaa-aaaaa-aaaaq-cai.localhost:8000
  // IC: canisterID(? back or front ?).raw.ic0.app
  public query func http_request(arg: HttpRequest) : async HttpResponse {
    {
      body = Text.encodeUtf8("<!DOCTYPE html><html><head><title>Current Counter Value</title></head><body><h1>Current Value is: " # Nat.toText(currentValue) # "</h1></body></html>");
      headers = [];
      status_code = 200;
    }
  };
}
