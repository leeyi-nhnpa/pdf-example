package comtech.pdf;

import comtech.util.DocumentXMLStreamWriter;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.fop.apps.Fop;
import org.apache.fop.apps.FopFactory;
import org.apache.fop.apps.MimeConstants;
import org.apache.fop.servlet.ServletContextURIResolver;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.stream.XMLStreamException;
import javax.xml.transform.*;
import javax.xml.transform.sax.SAXResult;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import java.io.*;

public class PdfServlet extends HttpServlet {

    private FopFactory fopFactory;
    private TransformerFactory transformerFactory;
    private URIResolver uriResolver;
    private ServletContext servletContext;

    private static Log log = LogFactory.getLog(PdfServlet.class);

    //Initialize global variables
    public void init() throws ServletException {
        this.servletContext = getServletContext();
        this.uriResolver = new ServletContextURIResolver(getServletContext());

        this.transformerFactory = TransformerFactory.newInstance();
        this.transformerFactory.setURIResolver(this.uriResolver);

        this.fopFactory = FopFactory.newInstance();
        this.fopFactory.setURIResolver(this.uriResolver);
        try {
            this.fopFactory.setUserConfig(new File(getServletContext().getRealPath("/fop/fop.xconf")));
        } catch (Exception e) {
            log.warn("got exception while creating invoice.pdf - fopfactory configuration error: ", e);
        }
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String invoiceXml = getXmlData();
            log.info("invoice.xml " + ":\n" + invoiceXml);
            byte[] invoicePdf = createInvoicePdf(invoiceXml);

            response.setDateHeader("Expires", System.currentTimeMillis() + 30 * 1000);
            response.setContentType("application/pdf");
            response.setContentLength(invoicePdf.length);

            response.getOutputStream().write(invoicePdf);
        } catch (XMLStreamException e) {
            throw new ServletException(e);
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    private byte[] createInvoicePdf(String invoiceXML) {
        try {
            //Setup a buffer to obtain the content length
            ByteArrayOutputStream out = new ByteArrayOutputStream();

            //Setup FOP
            Fop fop = fopFactory.newFop(MimeConstants.MIME_PDF, out);

            //Setup Transformer
            Source xsltSrc = this.uriResolver.resolve("servlet-context:/xslt/default.xsl", null);

            Transformer transformer = this.transformerFactory.newTransformer(xsltSrc);
            transformer.setURIResolver(this.uriResolver);

            //Setup input
            Source src = new StreamSource(new StringReader(invoiceXML));


            StringWriter sw = new StringWriter();
            Result res = new StreamResult(sw);

            //Start the transformation and rendering process
            transformer.transform(src, res);

            String invoiceFop = sw.toString();

//            log.info("invoice.fop.xml:\n" + invoiceFop);

            src = new StreamSource(new StringReader(invoiceFop));

            //Make sure the XSL transformation's result is piped through to FOP
            res = new SAXResult(fop.getDefaultHandler());


            transformerFactory.newTransformer().transform(src, res);

            return out.toByteArray();
        } catch (Exception e) {
            log.warn("got exception while creating invoice.pdf: ", e);
            return null;
        }
    }

    public String getXmlData() throws XMLStreamException {
        StringWriter out = new StringWriter();
        DocumentXMLStreamWriter document = new DocumentXMLStreamWriter(out);

        document.startDocument();
        document.startElement("invoice");

        document.element("number", "Сч-456");
        document.element("date", "13.01.2010");

        document.startElement("requisites");
        document.attribute("type", "purveyor");

        //purveyor related props...
        document.element("orgname", "ЗАО Авиакомпания");
        document.element("inn-kpp", "123123");
        document.element("bik", "123456");
        document.element("bank", "Сбербанк");
        document.element("correspondent-account", "11223344556677889900");
        document.element("settlement-account", "00998877665544332211");
        document.element("address", "г.Энск");
        document.element("phone", "111-111-111");
        document.element("fax", "111-111-111");

        // requisites
        document.endElement();

        document.startElement("requisites");
        document.attribute("type", "purchaser");

        document.element("orgname", "ООО Контора");
        document.element("inn-kpp", "3201222333 / 3201001");
        document.element("bik", "654321");
        document.element("account", "44444433333322222211");
        document.element("address", "г.Эмск");
        document.element("fax", "555-555-555");
        document.element("email", "referent@kontora.ru");
        document.element("phone", "555-555-555");

        // requisites
        document.endElement();

        document.startElement("requisites");
        document.attribute("type", "cargoSender");

        document.element("orgname", "ЗАО Грузоотправитель");
        document.element("address", "г.Энск");

        // requisites
        document.endElement();

        document.element("pnr", "073PDF");
        document.element("pnr_rus", "073ПДФ");

        document.startElement("customer");

        document.element("first-name", "Иванов");
        document.element("last-name", "Петр Сидорович");
        document.element("email", "ivanoff@gmail.com");
        document.element("phone", "333-333-333");
        document.element("address1", "г.Москва");
        document.element("address2", "Кремль");

        // customer
        document.endElement();

        document.startElement("passengers");
        document.startElement("passenger");
        document.attribute("id", "1");
        document.element("name", "Иванов Петр Сидорович");
        document.element("birthdate", "01.01.1970");
        document.element("nationality", "РФ");
        document.element("document-type", "ПС");
        document.element("document-number", "11 22 333444");
        document.element("document-expire", "01.01.2020");

        // passenger
        document.endElement();

        // passengers
        document.endElement();

        document.startElement("segments");
        document.startElement("segment");
        document.attribute("id", "1");
        document.element("aircompany-code", "AK");
        document.element("aircompany-name", "ЗАО Авиакомпания");

        document.element("flight-number", "AK-231");
        document.element("flight-class", "econom");

        document.element("departure-city", "ЕКБ");
        document.element("departure-airport", "КЛЦ");

        document.startElement("departure-date");
        document.attribute("timezone", "GMT+05:00");
        document.text("25.01.2010 10:00");
        document.endElement();

        document.element("arrival-city", "МОВ");
        document.element("arrival-airport", "ДМД");

        document.startElement("arrival-date");
        document.attribute("timezone", "GMT+03:00");
        document.text("25.01.2010 10:15");
        document.endElement();

        // segment
        document.endElement();
        // segments
        document.endElement();

        document.startElement("prices");
        document.startElement("price");
        document.attribute("passenger-id", "1");
        document.attribute("segment-id", "1");

        document.element("currency", "РУБ");
        document.element("fare-code", "MOW");
        document.element("fare-value", "1500.00");

        document.emptyElement("tax");
        document.attribute("name", "Топливный сбор");
        document.attribute("value", "500.00");

        document.emptyElement("tax");
        document.attribute("name", "Такса ТКП");
        document.attribute("value", "200.00");

        document.element("total-price", "2200.00");

        // price
        document.endElement();
        // prices
        document.endElement();

        document.startElement("payment-timelimit");
        document.attribute("timezone", "GMT+03:00");
        document.text("14.01.2010");
        document.endElement();

        document.element("flight-description", "ЕКБ-МОВ");

        document.element("passengers-count", "1");

        document.element("total-fare", "1500.00");
        document.element("total-tax", "700.00");
        document.element("delivery-tax", "0.00");

        document.element("total-agency-tax", "0.00");

        document.element("total-cost", "2200.00");

        document.element("total-nds", String.format("%.2f", Math.round(2200 / 1.18f * 18f) / 100f));

        document.element("total-cost-in-words", "Две тысячи двести рублей 00 копеек");

        document.element("head-post", "Директор");
        document.element("head-fio", "Босс Петр Петрович");

        document.element("head-signature-file-name", servletContext.getRealPath("/img/head_signature.gif"));

        document.element("bookkeeper-post", "Главный бухгалтер");
        document.element("bookkeeper-fio", "Счетоводова Клавдия Петровна");

        document.element("bookkeeper-signature-file-name", servletContext.getRealPath("/img/bookkeeper_signature.gif"));
        document.element("bookkeeper-press-file-name", servletContext.getRealPath("/img/bookkeeper_press.gif"));

        // invoice
        document.endElement();
        document.endDocument();

        return out.toString();
    }

}
