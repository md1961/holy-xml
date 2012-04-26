#! /usr/local/jruby/bin/jruby

require 'java'

module JavaIO
  include_package 'java.io'
end

module JavaxXmlParsers
  include_package 'javax.xml.parsers'
end

module OrgXmlSax
  include_package 'org.xml.sax'
end

=begin
import javax.xml.parsers.FactoryConfigurationError;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParserFactory;

import org.xml.sax.ErrorHandler;
import org.xml.sax.SAXException;
import org.xml.sax.SAXNotRecognizedException;
import org.xml.sax.SAXNotSupportedException;
import org.xml.sax.SAXParseException;
import org.xml.sax.XMLReader;
=end

class XmlSchemaValidator

  def parse
    begin
      objFactory = JavaxXmlParsers::SAXParserFactory.newInstance
    rescue => e
      raise e
    end
  end
end


if __FILE__ == $0
  xsv = XmlSchemaValidator.new
  xsv.parse
end


=begin
			XMLReader objReader = objFactory.newSAXParser().getXMLReader();
			objReader.setErrorHandler(new SchemaErrorHandler());
			objReader.setFeature(URL_VALIDATION, true);
			objReader.setFeature(URL_SCHEMA    , true);
			objReader.setFeature(URL_NAMESPACES, true);

			objReader.parse(xmlFilename);
			System.out.println(MESSAGE_COMPLETE);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private static final String MESSAGE_COMPLETE = "Parse complete.";

	private static final String URL_VALIDATION = "http://xml.org/sax/features/validation";
	private static final String URL_SCHEMA     = "http://apache.org/xml/features/validation/schema";
	private static final String URL_NAMESPACES = "http://xml.org/sax/features/namespaces";
}


class SchemaErrorHandler implements ErrorHandler {
	private SAXParseException e;

	public void warning(SAXParseException e) {
		this.e = e;
		printLineNumberAndMessage(LABEL_WARNING);
	}

	public void error(SAXParseException e) {
		this.e = e;
		printLineNumberAndMessage(LABEL_ERROR);
	}

	public void fatalError(SAXParseException e) {
		this.e = e;
		printLineNumberAndMessage(LABEL_FATAL);
	}

	private static final String FORMAT_ERROR_LEVEL_AND_LINE_NUMBER = "%s: Line %d\n";

	private void printLineNumberAndMessage(String strErrorLevel) {
		System.out.printf(FORMAT_ERROR_LEVEL_AND_LINE_NUMBER, strErrorLevel, e.getLineNumber());
		System.out.println(e.getMessage());
	}

	private static final String LABEL_WARNING = "Warning";
	private static final String LABEL_ERROR   = "Error";
	private static final String LABEL_FATAL   = "Fatal";
}
=end

