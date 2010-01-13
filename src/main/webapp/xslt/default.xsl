<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xsi:schemaLocation="http://www.w3.org/1999/XSL/Format
                http://svn.apache.org/repos/asf/xmlgraphics/fop/trunk/src/foschema/fop.xsd"
                exclude-result-prefixes="fo">
    <xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes"/>

    <xsl:template match="invoice">
        <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
            <fo:layout-master-set>
                <fo:simple-page-master master-name="simpleA4" page-height="29.7cm" page-width="21cm" margin-top="2cm"
                                       margin-bottom="2cm" margin-left="2cm" margin-right="2cm">
                    <fo:region-body/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            <fo:page-sequence master-reference="simpleA4">
                <fo:flow flow-name="xsl-region-body">
                    <fo:block font-size="14pt" font-weight="bold" space-after="2mm" text-align="center">
                        Счет на оплату №
                        <xsl:value-of select="number"/>
                        от
                        <xsl:value-of select="date"/>
                    </fo:block>

                    <xsl:apply-templates select="requisites"/>

                    <fo:block font-size="10pt" font-weight="bold" space-after="2mm">
                        Срок оплаты: не позднее
                        <xsl:value-of select="payment-timelimit"/>
                    </fo:block>

                    <fo:block font-size="10pt">
                        <fo:table table-layout="fixed" width="100%" space-after="2mm">
                            <fo:table-column column-width="6.5cm"/>
                            <fo:table-column column-width="2cm"/>
                            <fo:table-column column-width="2cm"/>
                            <fo:table-column column-width="2cm"/>
                            <fo:table-column column-width="2cm"/>
                            <fo:table-column column-width="2.5cm"/>
                            <fo:table-header>
                                <fo:table-row>
                                    <fo:table-cell border-width="1pt" border-style="solid" border-color="black"
                                                   vertical-align="middle">
                                        <fo:block text-align="center">Наименование</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell border-width="1pt" border-style="solid" border-color="black"
                                                   vertical-align="middle">
                                        <fo:block text-align="center">Ед.изм.</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell border-width="1pt" border-style="solid" border-color="black"
                                                   vertical-align="middle">
                                        <fo:block text-align="center">Кол-во</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell border-width="1pt" border-style="solid" border-color="black"
                                                   vertical-align="middle">
                                        <fo:block text-align="center">Цена</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell border-width="1pt" border-style="solid" border-color="black"
                                                   vertical-align="middle">
                                        <fo:block text-align="center">Сумма</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell border-width="1pt" border-style="solid" border-color="black"
                                                   vertical-align="middle">
                                        <fo:block text-align="center">Контракт</fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                                <fo:table-row>
                                    <fo:table-cell border-width="1pt" border-style="solid" border-color="black"
                                                   vertical-align="middle">
                                        <fo:block text-align="center">1</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell border-width="1pt" border-style="solid" border-color="black"
                                                   vertical-align="middle">
                                        <fo:block text-align="center">2</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell border-width="1pt" border-style="solid" border-color="black"
                                                   vertical-align="middle">
                                        <fo:block text-align="center">3</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell border-width="1pt" border-style="solid" border-color="black"
                                                   vertical-align="middle">
                                        <fo:block text-align="center">4</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell border-width="1pt" border-style="solid" border-color="black"
                                                   vertical-align="middle">
                                        <fo:block text-align="center">5</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell border-width="1pt" border-style="solid" border-color="black"
                                                   vertical-align="middle">
                                        <fo:block text-align="center">6</fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                            </fo:table-header>
                            <fo:table-body>
                                <fo:table-row>
                                    <fo:table-cell border-width="1pt" border-style="solid" border-color="black"
                                                   vertical-align="middle">
                                        <fo:block>
                                            <xsl:value-of select="flight-description"/>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell border-width="1pt" border-style="solid" border-color="black">
                                        <fo:block/>
                                    </fo:table-cell>
                                    <fo:table-cell border-width="1pt" border-style="solid" border-color="black"
                                                   vertical-align="middle">
                                        <fo:block text-align="center">
                                            1<!--<xsl:value-of select="passengers-count"/>-->
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell border-width="1pt" border-style="solid" border-color="black"
                                                   vertical-align="middle">
                                        <fo:block text-align="right">
                                            <xsl:value-of select="total-fare"/>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell border-width="1pt" border-style="solid" border-color="black"
                                                   vertical-align="middle">
                                        <fo:block text-align="right">
                                            <xsl:value-of select="total-fare"/>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell border-width="1pt" border-style="solid" border-color="black">
                                        <fo:block/>
                                    </fo:table-cell>
                                </fo:table-row>
                                <fo:table-row>
                                    <fo:table-cell border-width="1pt" border-style="solid" border-color="black">
                                        <fo:block>Сбор</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell border-width="1pt" border-style="solid" border-color="black">
                                        <fo:block/>
                                    </fo:table-cell>
                                    <fo:table-cell border-width="1pt" border-style="solid" border-color="black"
                                                   vertical-align="middle">
                                        <fo:block text-align="center">
                                            1<!--<xsl:value-of select="passengers-count"/>-->
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell border-width="1pt" border-style="solid" border-color="black"
                                                   vertical-align="middle">
                                        <fo:block text-align="right">
                                            <xsl:value-of select="total-tax"/>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell border-width="1pt" border-style="solid" border-color="black"
                                                   vertical-align="middle">
                                        <fo:block text-align="right">
                                            <xsl:value-of select="total-tax"/>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell border-width="1pt" border-style="solid" border-color="black">
                                        <fo:block/>
                                    </fo:table-cell>
                                </fo:table-row>
                                <xsl:if test="total-agency-tax">
                                    <fo:table-row>
                                        <fo:table-cell border-width="1pt" border-style="solid" border-color="black"
                                                       number-columns-spanned="4">
                                            <fo:block>Агентский сбор:</fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell border-width="1pt" border-style="solid" border-color="black"
                                                       vertical-align="middle">
                                            <fo:block text-align="right">
                                                <xsl:value-of select="total-agency-tax"/>
                                            </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell border-width="1pt" border-style="solid" border-color="black">
                                            <fo:block/>
                                        </fo:table-cell>
                                    </fo:table-row>
                                </xsl:if>
                                <xsl:if test="delivery-tax">
                                    <fo:table-row>
                                        <fo:table-cell border-width="1pt" border-style="solid" border-color="black"
                                                       number-columns-spanned="4">
                                            <fo:block>Стоимость доставки:</fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell border-width="1pt" border-style="solid" border-color="black"
                                                       vertical-align="middle">
                                            <fo:block text-align="right">
                                                <xsl:value-of select="delivery-tax"/>
                                            </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell border-width="1pt" border-style="solid" border-color="black">
                                            <fo:block/>
                                        </fo:table-cell>
                                    </fo:table-row>
                                </xsl:if>
                                <fo:table-row>
                                    <fo:table-cell border-width="1pt" border-style="solid" border-color="black"
                                                   number-columns-spanned="4">
                                        <fo:block>Всего к оплате</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell border-width="1pt" border-style="solid" border-color="black"
                                                   vertical-align="middle">
                                        <fo:block text-align="right">
                                            <xsl:value-of select="total-cost"/>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell border-width="1pt" border-style="solid" border-color="black">
                                        <fo:block/>
                                    </fo:table-cell>
                                </fo:table-row>
                            </fo:table-body>
                        </fo:table>
                    </fo:block>

                    <fo:block font-size="10pt" space-after="2mm">
                        Всего на сумму
                        <xsl:choose>
                            <xsl:when test="total-nds">
                                (в том числе НДС <xsl:value-of select="total-nds"/>):
                            </xsl:when>
                            <xsl:otherwise>
                                (без НДС):
                            </xsl:otherwise>
                        </xsl:choose>
                        <xsl:value-of select="total-cost-in-words"/>
                    </fo:block>

                    <fo:block font-size="10pt" space-after="2mm">
                        <fo:table table-layout="fixed" width="100%">
                            <fo:table-column column-width="8cm"/>
                            <fo:table-column column-width="1cm"/>
                            <fo:table-column column-width="4cm"/>
                            <fo:table-column column-width="4cm"/>
                            <fo:table-body>
                                <xsl:if test="head-post">
                                    <fo:table-row>
                                        <fo:table-cell display-align="center" height='3cm'>
                                            <fo:block>
                                                <xsl:value-of select="head-post"/>
                                            </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block-container height="5mm">
                                                <fo:block>
                                                    <xsl:if test="head-signature-file-name">
                                                        <fo:external-graphic content-height="2.5cm" src="">
                                                            <xsl:attribute name="src">
                                                                <xsl:value-of select="head-signature-file-name"/>
                                                            </xsl:attribute>
                                                        </fo:external-graphic>
                                                    </xsl:if>
                                                </fo:block>
                                            </fo:block-container>
                                        </fo:table-cell>
                                        <fo:table-cell number-columns-spanned="2" display-align="center" height='3cm'>
                                            <fo:block text-align="center">
                                                <xsl:value-of select="head-fio"/>
                                            </fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                </xsl:if>
                                <fo:table-row>
                                    <fo:table-cell display-align="center" height='3cm'>
                                        <fo:block>
                                            <xsl:value-of select="bookkeeper-post"/>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block-container height="5mm">
                                            <fo:block>
                                                <xsl:if test="bookkeeper-signature-file-name">
                                                    <fo:external-graphic content-height="2.5cm" src="">
                                                        <xsl:attribute name="src">
                                                            <xsl:value-of select="bookkeeper-signature-file-name"/>
                                                        </xsl:attribute>
                                                    </fo:external-graphic>
                                                </xsl:if>
                                            </fo:block>
                                        </fo:block-container>
                                    </fo:table-cell>
                                    <fo:table-cell number-columns-spanned="2" display-align="center" height='3cm'>
                                        <fo:block text-align="center">
                                            <xsl:value-of select="bookkeeper-fio"/>
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                                <fo:table-row>
                                    <fo:table-cell>
                                        <fo:block>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block-container height="5mm">
                                            <fo:block>
                                                <xsl:if test="bookkeeper-press-file-name">
                                                    <fo:external-graphic content-height="4.5cm" src="">
                                                        <xsl:attribute name="src">
                                                            <xsl:value-of select="bookkeeper-press-file-name"/>
                                                        </xsl:attribute>
                                                    </fo:external-graphic>
                                                </xsl:if>
                                            </fo:block>
                                        </fo:block-container>
                                    </fo:table-cell>
                                </fo:table-row>
                            </fo:table-body>
                        </fo:table>
                    </fo:block>

                    <fo:block font-size="6pt">Примечание. Без печати недействительно.</fo:block>
                    <fo:block font-size="6pt">Первый экземпляр (оригинал) - покупателю. Второй экземпляр (копия) -
                        продавцу.
                    </fo:block>
                    <fo:block font-size="6pt">Тариф на авиаперевозку действителен на дату оплаты счета.</fo:block>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>

    <xsl:template match="requisites">
        <fo:block font-size="10pt" space-after="2mm">
            <fo:table table-layout="fixed" width="100%">
                <fo:table-column column-width="5cm"/>
                <fo:table-column column-width="12cm"/>
                <fo:table-body>
                    <fo:table-row>
                        <fo:table-cell>
                            <xsl:if test="@type = 'purchaser'">
                                <fo:block>Покупатель</fo:block>
                            </xsl:if>
                            <xsl:if test="@type = 'purveyor'">
                                <fo:block>Поставщик</fo:block>
                            </xsl:if>
                            <xsl:if test="@type = 'cargoSender'">
                                <fo:block>Грузоотправитель</fo:block>
                            </xsl:if>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block>
                                <xsl:value-of select="orgname"/>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <xsl:if test="inn-kpp">
                        <fo:table-row>
                            <fo:table-cell>
                                <fo:block>ИНН/КПП</fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block>
                                    <xsl:value-of select="inn-kpp"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </xsl:if>
                    <xsl:if test="bik">
                        <fo:table-row>
                            <fo:table-cell>
                                <fo:block>БИК</fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block>
                                    <xsl:value-of select="bik"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </xsl:if>
                    <xsl:if test="bank">
                        <fo:table-row>
                            <fo:table-cell>
                                <fo:block>Банк</fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block>
                                    <xsl:value-of select="bank"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </xsl:if>
                    <xsl:if test="account">
                        <fo:table-row>
                            <fo:table-cell>
                                <fo:block>Корр.счет/Расч.счет №</fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block>
                                    <xsl:value-of select="account"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </xsl:if>
                    <xsl:if test="correspondent-account">
                        <fo:table-row>
                            <fo:table-cell>
                                <fo:block>Корр.счет №</fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block>
                                    <xsl:value-of select="correspondent-account"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </xsl:if>
                    <xsl:if test="settlement-account">
                        <fo:table-row>
                            <fo:table-cell>
                                <fo:block>Расч.счет №</fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block>
                                    <xsl:value-of select="settlement-account"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </xsl:if>
                    <xsl:if test="address">
                        <fo:table-row>
                            <fo:table-cell>
                                <fo:block>Адрес</fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block>
                                    <xsl:value-of select="address"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </xsl:if>
                    <xsl:if test="phone">
                        <fo:table-row>
                            <fo:table-cell>
                                <fo:block>Телефон</fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block>
                                    <xsl:value-of select="phone"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </xsl:if>
                    <xsl:if test="fax">
                        <fo:table-row>
                            <fo:table-cell>
                                <fo:block>Факс</fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block>
                                    <xsl:value-of select="fax"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </xsl:if>
                    <xsl:if test="email">
                        <fo:table-row>
                            <fo:table-cell>
                                <fo:block>E-mail</fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block>
                                    <xsl:value-of select="email"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </xsl:if>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>

</xsl:stylesheet>
