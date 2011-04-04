package net.minodisk.util {
	
	/**
	 * @langversion ActionScript 3.0
	 * @playerversion 9.0
	 * @author dsk
	 * @since 2011/03/11
	 */
	public class XMLUtility {
		
		//--------------------------------------
		// CLASS CONSTANTS
		//--------------------------------------
		
		
		//--------------------------------------
		// PRIVATE VARIABLES
		//--------------------------------------
		
		
		//--------------------------------------
		// GETTER/SETTERS
		//--------------------------------------
		
		
		//--------------------------------------
		// PUBLIC METHODS
		//--------------------------------------
		
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
		
		
		//--------------------------------------
		// PRIVATE METHODS
		//--------------------------------------
		
		
	}
	
	
}
