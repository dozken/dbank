import Debug "mo:base/Debug";
import Error "mo:base/Error";
import Float "mo:base/Float";
import Nat "mo:base/Nat";
import Time "mo:base/Time";
import Result "mo:base/Result";

actor DBank {
  stable var currentValue: Float = 300;

  // let id = 123123123434;
  let startTime = Time.now();
  Debug.print(debug_show(startTime));
  Debug.print("Initial value: " # Float.toText(currentValue));

  public func topUp(amount: Float) {
    currentValue += amount;
    Debug.print("Top up: " # Float.toText(currentValue));
  };

  public func withdraw(amount: Float){
    let tempValue: Float = currentValue - amount;
    if(tempValue < 0) {
      Debug.print("Cannot withdraw, not enough balance: " # Float.toText(amount));   
      // throw Error.reject("Cannot withdraw, not enough balance: " # Float.toText(amount)); 
    };
    currentValue -= amount;
    Debug.print("Withdraw: " # Float.toText(currentValue));
  };

  public query func checkBalance(): async Float {
    return currentValue;
  };

  public func compound() {
    let currentTime = Time.now();
    let timeElapsedNS = currentTime - startTime;
    let timeElapsedS = timeElapsedNS / 1_000_000_000;
    currentValue := currentValue * (1.01 **  Float.fromInt(timeElapsedS));   
  }

}