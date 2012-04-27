#! /usr/local/jruby/bin/jruby

include Java


class XmlSchemaValidator

  def parse(xml_filename)
    begin
      objFactory = javax.xml.parsers.SAXParserFactory.newInstance

			objReader = objFactory.newSAXParser.getXMLReader
			objReader.setErrorHandler(SchemaErrorHandler.new)
			objReader.setFeature(URL_VALIDATION, true)
			objReader.setFeature(URL_SCHEMA    , true)
			objReader.setFeature(URL_NAMESPACES, true)

			objReader.parse(xml_filename)
      puts MESSAGE_COMPLETE
    rescue => e
      raise e
    end
  end

	MESSAGE_COMPLETE = "Parse complete."

	URL_VALIDATION = "http://xml.org/sax/features/validation"
	URL_SCHEMA     = "http://apache.org/xml/features/validation/schema"
	URL_NAMESPACES = "http://xml.org/sax/features/namespaces"
end


class SchemaErrorHandler
  java_implements "org.xml.sax.ErrorHandler"

  java_signature "void warning(SAXParseException)"
	def warning(e)
		@e = e
		print_line_number_and_message(LABEL_WARNING)
  end

  java_signature "void error(SAXParseException)"
	def error(e)
		@e = e
		print_line_number_and_message(LABEL_ERROR)
  end

  java_signature "void fatalError(SAXParseException)"
	def fatalError(e)
		@e = e
		print_line_number_and_message(LABEL_FATAL)
  end

	FORMAT_ERROR_LEVEL_AND_LINE_NUMBER = "%s: Line %d"

	def print_line_number_and_message(strErrorLevel)
		puts FORMAT_ERROR_LEVEL_AND_LINE_NUMBER % [strErrorLevel, @e.getLineNumber]
		puts @e.getMessage
  end

	LABEL_WARNING = "Warning"
	LABEL_ERROR   = "Error"
	LABEL_FATAL   = "Fatal"
end


if __FILE__ == $0
  xsv = XmlSchemaValidator.new
  xsv.parse(ARGV[0])
end

