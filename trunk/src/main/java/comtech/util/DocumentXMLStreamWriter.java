package comtech.util;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.stream.XMLOutputFactory;
import javax.xml.stream.XMLStreamException;
import javax.xml.stream.XMLStreamWriter;
import java.io.OutputStream;
import java.io.Writer;
import java.util.Map;

/**
 * User: Vlad Vinichenko (akerigan@gmail.com)
 * Date: 04.09.2009
 * Time: 13:07:24
 */
public class DocumentXMLStreamWriter {

    private static final XMLOutputFactory factory = XMLOutputFactory.newInstance();
    private XMLStreamWriter writer;

    public DocumentXMLStreamWriter(OutputStream stream) throws XMLStreamException {
        this.writer = factory.createXMLStreamWriter(stream, "utf-8");
    }

    public DocumentXMLStreamWriter(Writer writer) throws XMLStreamException {
        this.writer = factory.createXMLStreamWriter(writer);
    }

    public void startDocument() throws XMLStreamException {
        writer.writeStartDocument();
    }

    public void startDocument(String encoding, String version) throws XMLStreamException {
        writer.writeStartDocument(encoding, version);
    }

    public void endDocument() throws XMLStreamException {
        writer.writeEndDocument();
        writer.flush();
        writer.close();
    }

    public void startElement(String localName) throws XMLStreamException {
        writer.writeStartElement(localName);
    }

    public void startElement(String prefix, String localName, String namespaceURI) throws XMLStreamException {
        writer.writeStartElement(prefix, localName, namespaceURI);
    }

    public void namespace(String prefix, String namespaceURI) throws XMLStreamException {
        writer.setPrefix(prefix, namespaceURI);
        writer.writeNamespace(prefix, namespaceURI);
    }

    public void endElement() throws XMLStreamException {
        writer.writeEndElement();
    }

    public void attribute(String name, Object value) throws XMLStreamException {
        if (value != null) {
            writer.writeAttribute(name, value.toString());
        }
    }

    public void element(String localName, Object value) throws XMLStreamException {
        writer.writeStartElement(localName);
        if (value != null) {
            writer.writeCharacters(value.toString());
        }
        writer.writeEndElement();
    }

    public void element(String prefix, String localName, String namespaceURI, Object value) throws XMLStreamException {
        writer.writeStartElement(prefix, localName, namespaceURI);
        if (value != null) {
            writer.writeCharacters(value.toString());
        }
        writer.writeEndElement();
    }

    public void emptyElement(String name) throws XMLStreamException {
        writer.writeEmptyElement(name);
    }

    public void element(
            String name,
            Map<String, String> attributes,
            Object value) throws XMLStreamException {

        writer.writeStartElement(name);
        for (Map.Entry<String, String> entry : attributes.entrySet()) {
            writer.writeAttribute(entry.getKey(), entry.getValue());
        }
        if (value != null) {
            writer.writeCharacters(value.toString());
        }
        writer.writeEndElement();
    }

    public void element(String name, Map<String, String> attributes) throws XMLStreamException {
        writer.writeEmptyElement(name);
        for (Map.Entry<String, String> entry : attributes.entrySet()) {
            writer.writeAttribute(entry.getKey(), entry.getValue());
        }
    }

    public void text(Object value) throws XMLStreamException {
        writer.writeCharacters(value.toString());
    }

    public void object(Object object) throws XMLStreamException {
        if (object != null) {
            ExistingDocumentXMLStreamWriter wrappedWriter = new ExistingDocumentXMLStreamWriter(writer);
            try {
                JAXBContext jaxbContext = JAXBContext.newInstance(object.getClass());
                Marshaller marshaller = jaxbContext.createMarshaller();
                marshaller.marshal(object, wrappedWriter);
            } catch (JAXBException e) {
                throw new XMLStreamException(e);
            }
        }
    }

    public void processingInstruction(String target) throws XMLStreamException {
        writer.writeProcessingInstruction(target);
    }
}