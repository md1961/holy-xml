import java.io.IOException;

import javax.xml.parsers.FactoryConfigurationError;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParserFactory;

import org.xml.sax.ErrorHandler;
import org.xml.sax.SAXException;
import org.xml.sax.SAXNotRecognizedException;
import org.xml.sax.SAXNotSupportedException;
import org.xml.sax.SAXParseException;
import org.xml.sax.XMLReader;


public class XmlSchemaValidator {
	public static void main(String[] args) {
		String xmlFilename = args[0];

		try {
			SAXParserFactory objFactory = SAXParserFactory.newInstance();
			XMLReader objReader = objFactory.newSAXParser().getXMLReader();
			objReader.setErrorHandler(new SchemaErr());
			objReader.setFeature("http://xml.org/sax/features/validation", true);
			objReader.setFeature("http://apache.org/xml/features/validation/schema", true);
			objReader.setFeature("http://xml.org/sax/features/namespaces", true);

			objReader.parse(xmlFilename);
			System.out.println("Parse complete.");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}


class SchemaErr implements ErrorHandler {
	private SAXParseException e;

	public void warning(SAXParseException e) {
		this.e = e;
		printLineNumberAndMessage("Warning");
	}

	public void error(SAXParseException e) {
		this.e = e;
		printLineNumberAndMessage("Error");
	}

	public void fatalError(SAXParseException e) {
		this.e = e;
		printLineNumberAndMessage("Fatal Error");
	}

	private void printLineNumberAndMessage(String strErrorLevel) {
		System.out.println(strErrorLevel + ": Line " + e.getLineNumber());
		System.out.println(e.getMessage());
	}
}

