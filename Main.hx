@:forward(push, pop)
abstract MyArray<S>(Array<S>) {
  public function new() {
    // Adding a breakpoint below will not work, the js debugger will never stop here...
    this = [];
  }
}

class Main {
  static public function main() {
    // The following is NOT needed for the debugging source-map support but only for runtime
    // source-map support, wich is a nice way to get stacktraces that point to the Haxe source
    // instead of the js file.
    // Source: https://stackoverflow.com/questions/33778714/haxe-nodejs-debugging-source-mapping

    #if !clientjs
    js.Lib.require('source-map-support').install();
    haxe.CallStack.wrapCallSite = js.Lib.require('source-map-support').wrapCallSite;
    #end
    // When using vscode, adding breakpoints here will work as long as `-debug` is added to the build.hxml.
    // the debugger will stop in the Haxe code and not the js code (using the source-maps).

    // MyArray won't be inspectable when debugging, because it only exists during compile-time
    var myArray = new MyArray();
    myArray.push(12);
    myArray.pop();

    // This tests runtime source-mapping
    throw 'test';
  }
}
