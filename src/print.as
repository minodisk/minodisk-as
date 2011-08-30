package {
  
  public function print(...texts):void {
    if (printable) {
      trace.apply(null, texts);
    }
  }
  
}