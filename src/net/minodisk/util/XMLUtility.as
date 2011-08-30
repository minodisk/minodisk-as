package net.minodisk.util {
	
	public class XMLUtility {
		
		static public function hasValue(context:XML, propertyName:String):Boolean {
			return context && context.hasOwnProperty(propertyName) && (String(context[propertyName]) !== '');
		}
		
		static public function getTextAsString(node:XML):String {
			return node ? String(node.text()) : '';
		}
		
		static public function getTextAsNumber(node:XML):Number {
			return node ? Number(node.text()) : -1;
		}
		
		static public function addDirectoryPath(context:XML, directories:XMLList, base:String = ''):void {
			var i:int, iLen:int, directory:XML, nodeName:String, directoryPath:String,
				nodes:XMLList, j:int, jLen:int, node:XML;
			for (i = 0, iLen = directories.length(); i < iLen; i++) {
				directory = directories[i];
				nodeName = String(directory.@rel);
				directoryPath = base + String(directory.text());
				nodes = context.descendants(nodeName);
				jLen = nodes.length();
				for (j = 0; j < jLen; j++) {
					node = nodes[j];
					node.@src = directoryPath + String(node.@src);
				}
			}
		}
    
    static public function toDeclaredString(xml:XML):String {
      return '<?xml version="1.0" encoding="utf-8" ?>\n' + xml.toXMLString();
    }
    
    static public function wrapWithCDATA(value:String):XML {
      return new XML('<![CDATA[' + value + ']]>');
    }
		
		
	}
}