<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    version="2.0"> <!-- sert à indiquer la version que l'on souhaite utiliser et les espaces de noms pris en compte dans le document ci-dessous -->

    <xsl:output method="html" indent="yes"/> <!-- xsl:output sert à indiquer vers quel language la transformation doit opérer avec @method. @intent sert à indiquer le résultat sera indenté -->


    <!-- VARIABLES GÉNÉRALES -->
    
    <xsl:variable name="nicolay1708" select="concat('https://gallica.bnf.fr/ark:/12148/', //bibl/idno)"/> <!-- utilisation de CONCAT pour créer l'URI entière à partir de l'identifiant ARK -->
    <xsl:variable name="nicolay1785" select="concat('Arch. nat, ', //item[@n = '2']//idno)"/> <!-- utilisation de CONCAT pour créer la cote -->
    <xsl:variable name="nicolay1815" select="concat('Arch. nat, ', //item[@n = '3']//idno)"/> <!-- utilisation de CONCAT pour créer la cote -->


    <!-- VARIABLE HEAD CONTENANT LES MÉTADONNÉES DES PAGES DU SITE -->
    
    <xsl:variable name="head">
        <head>
            <meta charset="utf-8"/> <!-- encodage utilisé -->
            <title>La mort chez les Nicolay</title> <!-- en-tête des pages -->
            <link href="../css/nicolay.css" rel="stylesheet"/> <!-- indique le chemin vers le fichier CSS utilisé pour l'habillage du site -->
        </head>
    </xsl:variable>
    

    <!-- VARIABLE NAVBAR CONTENANT LA BARRE DE NAVIGATION -->
    
    <xsl:variable name="navbar">
        <nav>
            <h1 class="nav-h1"><xsl:value-of select="//titleStmt/title"/></h1> <!-- indication d'une classe html pour l'habillage CSS -->
            <ul class="nav-ul">
                <li>
                    <a class="nav-a" href="home.html">Accueil</a> - <!-- ajout de tirets pour séparer visuellement les liens -->
                </li>
                <xsl:for-each select="//list/item[@n]">
                    <xsl:variable name="pagenum" select="concat('page', ./@n)"/> <!-- variable permettant de créer dynamiquement les noms de pages -->
                    <xsl:if test="./bibl"> <!-- test afin de récupérer les informations dans 'bibl' pour l'item 1 -->
                        <li>
                            <a class="nav-a" href="{$pagenum}.html"> <!-- création de l'URL à partir de la variable pagenum -->
                                <xsl:value-of select="./bibl/title[@type = 'titre_texte']"/>
                            </a> -
                        </li>
                    </xsl:if>
                    <xsl:if test="./msDesc"> <!-- test pour récupérer les informations dans msName pour les items 2/3 -->
                        <li>
                            <a class="nav-a" href="{$pagenum}.html">
                                <xsl:value-of select=".//msName"/>
                            </a> -
                        </li>
                    </xsl:if>
                </xsl:for-each>
                <li>
                    <a class="nav-a" href="index.html">Index des noms</a>
                </li>
            </ul>
        </nav>
    </xsl:variable>
    

    <!-- VARIABLE FOOTER INDIQUANT LES MENTIONS LÉGALES DU SITE -->
    
    <xsl:variable name="footer">
        <footer>
            <p>Site réalisé pour l'évaluation finale du cours de XSLT du M2 TNAH de l'École
                nationale des chartes, 2025-2026.</p> <!-- ici un simple paragraphe suffit -->
        </footer>
    </xsl:variable>


    <!-- TEMPLATES DES PAGES DU SITE -->

    <!-- 1. appel des templates avec un xsl:template général -->

    <xsl:template match="/TEI"> <!-- permet d'indiquer que l'on prend en compte l'ensemble du document -->
        <xsl:call-template name="accueil"/>
        <xsl:call-template name="mainpage"/>
        <xsl:call-template name="index"/>
        <!-- 'call-template' indique qu'il faut exécuter les autres templates ci-dessous -->
    </xsl:template>

    <!-- 2. templates de pages -->

    <!-- TEMPLATE DE LA PAGE D'ACCUEIL -->
    <xsl:template name="accueil">
        <xsl:result-document href="html/home.html" method="html" indent="yes"> <!-- 'result-document' permet d'indiquer que l'on veut un document de sortie, ici en html indenté -->
            <html lang="fr"> <!-- balise racine HTML -->
                <xsl:copy-of select="$head"/> <!-- appel de la variable head définie plus haut -->
                <body>
                    <xsl:copy-of select="$navbar"/> <!-- appel de la variable navbar -->
                    <h2>Au sujet de ce site</h2>
                    <p>Ce site est le résultat de la conduite des projets finaux des classes de
                        XML-TEI et de XSLT du master 2 TNAH de l'École nationale des chartes. Il
                        fait suite aux travaux de l'encodeur lors de son précédent master, et
                        reprend les testaments de plusieurs membres de la famille Nicolay aux XVIIIe
                        et XIXe siècles. L'objectif lors de la création a été de créer une version
                        numérique des textes doublés d'un appareil critique prenant la forme d'une
                        'notice'.</p>
                    <p>
                        Il est question ici de la branche des marquis de Goussainville, installée à Paris 
                        en raison de la charge de premier président de la Chambre des comptes de Paris qui 
                        fonda leur prétention à la noblesse et qu'ils tinrent héréditairement de la fin du 
                        XIVe siècle à la Révolution. Dévôts ultramontains au XVIIIe siècle, les membres de la 
                        famille laissent transparaître dans leurs testaments des pratiques communes qui se transmettent
                        de génération en génération malgré l'évolution des moeurs aux XVIIIe et XIXe siècles.
                    </p>
                    <h2>Ressources du site</h2>
                    <p>Le projet se base sur de multiples sources issues à la fois des Archives
                        nationales et de Gallica. Vous pouvez les consulter ci-dessous :</p>
                    <ul> <!-- sert à indiquer les titres des différents textes et leur source/cote, le cas échéant) -->
                        <li>
                            <a href="page1.html"><xsl:value-of select="//bibl/title[@type = 'titre_texte']"/></a>, (source : <a href="{$nicolay1708}"><xsl:value-of select="//bibl/title[@type = 'titre_livre']"/></a>) <!-- liens vers d'autres pages du site et vers gallica -->
                        </li>
                        <li>
                            <a href="page2.html"><xsl:value-of select="//item[@n='2']//msName"/></a>, (source : <xsl:value-of select="$nicolay1785"/>)
                        </li>
                        <li>
                            <a href="page3.html"><xsl:value-of select="//item[@n='3']//msName"/></a>, (source : <xsl:value-of select="$nicolay1815"/>)
                        </li>
                    </ul>
                    <p>Le site dispose aussi d'un index des noms, lieux et organisations mentionnés dans les textes que vous pouvez consulter ici : <a href="index.html">index des noms</a>.</p>
                    <hr/>
                    <xsl:copy-of select="$footer"/> <!-- appel de la variable footer -->
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>

    <!-- template contenant le code des pages de texte, avec une boucle permettant de créer une page par extrait contenant plusieurs templates appelées pour créer différentes sections -->

    <xsl:template name="mainpage">
        <xsl:for-each select="//div[@n]"> <!-- sélection des divs avec un nombre par le biais d'un prédicat -->
            <xsl:variable name="pagenum" select="concat('page', ./@n, '.html')"/> <!-- variable permettant de créer le nom de la page -->
            <xsl:result-document href="html/{$pagenum}" method="html" indent="yes"> <!-- result-document permet de créer le document de sortie au format HTML -->
                <html lang="fr">
                    <xsl:copy-of select="$head"/>
                    <body>
                        <xsl:copy-of select="$navbar"/>
                        <main>
                            <div class="texte"> <!-- première section de la page contenant le texte transcrit du document -->
                                <xsl:for-each select="./div[@type]"> <!-- sélection des divs à l'intérieur de chaque texte -->
                                    <div>
                                        <xsl:apply-templates select="opener"/> <!-- on applique les templates internes pour s'assurer que tout le texte soit correctement pris en compte -->
                                        <xsl:apply-templates select="p"/>
                                        <xsl:apply-templates select="closer"/>
                                        <xsl:apply-templates select="signed"/>
                                    </div>
                                </xsl:for-each>
                            </div>
                            <div class="notice"> <!-- deuxième section de la page contenant les métadonnées descriptives du document -->
                                <table> <!-- construction d'un tableau pour arranger les métadonnées -->
                                    <tbody>
                                        <!-- TITRE -->
                                        <tr>
                                            <th>TITRE</th> <!-- en-tête de colonne -->
                                            <td> 
                                                <xsl:choose> <!-- l'utilisation de xsl:choose pour les valeurs permet de ne pas dupliquer la structure et facilite la lecture du code -->
                                                    <xsl:when test="@n[parent::div] = '1'"> <!-- on sélectionne la provenance de l'information selon le texte, ici désigné par @n pour des facilités de lecture. @xml:id aurait aussi été possible -->
                                                        <xsl:value-of select="upper-case(//TEI//bibl/title[@type = 'titre_texte'])"/> <!-- utilisation d'un prédicat spécifique pour obtenir le titre correspondant, et de UPPER-CASE() pour mettre le tout en majuscules -->
                                                    </xsl:when>
                                                    <xsl:when test="@n[parent::div] = '2'">
                                                        <xsl:value-of select="upper-case(//item[2]//msName)"/>
                                                    </xsl:when>
                                                    <xsl:when test="@n[parent::div] = '3'">
                                                        <xsl:value-of select="upper-case(//item[3]//msName)"/>
                                                    </xsl:when>
                                                </xsl:choose> 
                                            </td>
                                        </tr>
                                        <!-- SOURCE/COTE -->
                                        <tr>
                                            <xsl:choose>
                                                <xsl:when test="@n[parent::div] = '1'">
                                                    <th>Source</th> <!-- le nom de la colonne étant appelé à changer selon les textes, <th> est inclus dans le xsl:choose -->
                                                    <td> <!-- pareil pour <td> -->
                                                        <xsl:value-of select="//bibl/title[@type = 'titre_livre']"/> (<a href="{$nicolay1708}"><xsl:value-of select="$nicolay1708"/></a>) <!-- utilisation du variable pour créer le lien -->
                                                    </td>
                                                </xsl:when>
                                                <xsl:when test="@n[parent::div] = '2'">
                                                    <th>Cote</th> <!-- changement de nom de la colonne -->
                                                    <td>
                                                        <xsl:value-of select="$nicolay1785"/>
                                                    </td>
                                                </xsl:when>
                                                <xsl:when test="@n[parent::div] = '3'">
                                                    <th>Cote</th>
                                                    <td>
                                                        <xsl:value-of select="$nicolay1815"/>
                                                    </td>
                                                </xsl:when>
                                            </xsl:choose>
                                        </tr>
                                        <!-- AUTEUR -->
                                        <tr>
                                            <th>Auteur</th> <!-- nom d'auteur du texte original -->
                                            <td>
                                                <xsl:choose>
                                                    <xsl:when test="@n[parent::div] = '1'">
                                                        <xsl:value-of select="//bibl/author"/>
                                                    </xsl:when>
                                                    <xsl:when test="@n[parent::div] = '2'">
                                                        <xsl:value-of select="//item[2]//name[@type = 'author']"/>
                                                    </xsl:when>
                                                    <xsl:when test="@n[parent::div] = '3'">
                                                        <xsl:value-of select="//item[3]//name[@type = 'author']"/>
                                                    </xsl:when>
                                                </xsl:choose>
                                            </td>
                                        </tr>
                                        <!-- EDITEUR -->
                                        <xsl:if test="@n[parent::div] = '1'"> <!-- on n'autorise la catégorie éditeur à exister que pour le texte 1 -->
                                            <tr>
                                                <th>Éditeur</th> <!-- éditeur du recueil d'actes et papiers de la famille -->
                                                <td>
                                                    <xsl:value-of select="//bibl/editor"/> <!-- nom de l'éditeur pour le texte de 1709 -->
                                                </td>
                                            </tr>
                                        </xsl:if>
                                        <!-- DATE -->
                                        <xsl:choose> <!-- xsl:choose au niveau de <tr> pour la date car le texte de 1709 dispose de deux dates -->
                                            <xsl:when test="@n[parent::div] = '1'">
                                                <tr>
                                                    <th>Date d'origine</th>
                                                    <td>
                                                        <xsl:value-of select="//bibl/date[@type = 'date_texte']"/> <!-- date d'écriture du texte original -->
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th>Date d'édition</th>
                                                    <td>
                                                        <xsl:value-of select="//bibl/date[@type = 'date_livre']"/> <!-- date d'édition de l'ouvrage de Boislisle -->
                                                    </td>
                                                </tr>
                                            </xsl:when>
                                            <xsl:when test="@n[parent::div] = '2'">
                                                <tr>
                                                    <th>Date</th>
                                                    <td>
                                                        <xsl:value-of select="//item[2]//summary/date"/>
                                                    </td>
                                                </tr>
                                            </xsl:when>
                                            <xsl:when test="@n[parent::div] = '3'">
                                                <tr>
                                                    <th>Date</th>
                                                    <td>
                                                        <xsl:value-of select="//item[3]//summary/date"/>
                                                    </td>
                                                </tr>
                                            </xsl:when>
                                        </xsl:choose>
                                        <!-- DESCRIPTION GÉNÉRALE -->
                                        <tr>
                                            <th>Description</th>
                                            <td>
                                                <xsl:choose>
                                                    <xsl:when test="@n[parent::div] = '1'">
                                                        <xsl:value-of select="//item[@n = '1']/p"/> <!-- récupération de la description par le biais du numéro d'item -->
                                                    </xsl:when>
                                                    <xsl:when test="@n[parent::div] = '2'">
                                                        <xsl:value-of select="//item[@n = '2']//summary/p"/>
                                                    </xsl:when>
                                                    <xsl:when test="@n[parent::div] = '3'">
                                                        <xsl:value-of select="//item[@n = '3']//summary/p"/>
                                                    </xsl:when>
                                                </xsl:choose>
                                            </td>
                                        </tr>
                                        <!-- ANALYSE PAR PARTIE -->
                                        <tr>
                                            <th>Analyse par partie</th> <!-- récupération des descriptions des sous-parties -->
                                            <td>
                                                <xsl:choose>
                                                    <xsl:when test="@n[parent::div] = '1'">
                                                        <xsl:for-each select="//spanGrp[@n = '1']/span"> <!-- boucle permettant de récupérer le contenu des éléments 'span' du spanGrp correspondant -->
                                                            <p>
                                                                <xsl:if test="./@target = '#proto'">Protocole : </xsl:if> <!-- test permettant d'indiquer un nom de partie selon l'attribut @target de l'élément span -->
                                                                <xsl:if test="./@target = '#bt01'">Partie 1 : </xsl:if>
                                                                <xsl:if test="./@target = '#bt02'">Partie 2 : </xsl:if>
                                                                <xsl:value-of select="."/>
                                                            </p>
                                                        </xsl:for-each>
                                                    </xsl:when>
                                                    <xsl:when test="@n[parent::div] = '2'">
                                                        <xsl:for-each select="//spanGrp[@n = '2']/span">
                                                            <p>
                                                                <xsl:if test="./@target = '#proto2'">Protocole : </xsl:if>
                                                                <xsl:if test="./@target = '#bt201'">Partie 1 : </xsl:if>
                                                                <xsl:if test="./@target = '#bt202'">Partie 2 : </xsl:if>
                                                                <xsl:if test="./@target = '#bt203'">Partie 3 : </xsl:if>
                                                                <xsl:value-of select="."/>
                                                            </p>
                                                        </xsl:for-each>
                                                    </xsl:when>
                                                    <xsl:when test="@n[parent::div] = '3'">
                                                        <xsl:for-each select="//spanGrp[@n = '3']/span">
                                                            <p>
                                                                <xsl:if test="./@target = '#proto3'">Protocole : </xsl:if>
                                                                <xsl:if test="./@target = '#bt301'">Partie 1 : </xsl:if>
                                                                <xsl:if test="./@target = '#bt302'">Partie 2 : </xsl:if>
                                                                <xsl:if test="./@target = '#bt303'">Partie 3 : </xsl:if>
                                                                <xsl:if test="./@target = '#escha3'">Eschatocole : </xsl:if>
                                                                <xsl:value-of select="."/>
                                                            </p>
                                                        </xsl:for-each>
                                                    </xsl:when>
                                                </xsl:choose>
                                            </td>
                                        </tr>
                                        <!-- PERSONNES, LIEUX, ORGANISATIONS CITÉES -->
                                        <!-- ici, on utilise for:each pour créer des listes à puces de noms présents dans le texte avec le paragraphe d'origine -->
                                        <!-- j'avais prévu d'utiliser for-each-group au départ ici, mais pour une quelconque raison le résultat n'était pas satisfaisant -->
                                        <tr>
                                            <th>Cités dans ce document</th> <!-- partie récupérant les entités nommées  -->
                                            <td>
                                            <xsl:choose> <!-- xsl:choose déterminant le texte visé -->
                                                <xsl:when test="@n[parent::div] = '1'"> <!-- TEXTE 1 -->
                                                    <p>Organisations religieuses</p> <!-- en-tête de liste -->
                                                    <ul> <!-- indication que l'on crée une liste à puces -->
                                                    <xsl:for-each select="//div[@xml:id = 'nicolay1708']//orgName"> <!-- frecherche de <orgName> pour les organisations -->
                                                            <li>
                                                                <xsl:value-of select="."/> <!-- valeur de la sélection -->
                                                                <xsl:text> [§</xsl:text>
                                                                <xsl:value-of select="parent::p/@n"/> <!-- valeur numérique du paragraphe parent -->
                                                                <xsl:text>]</xsl:text>
                                                            </li>
                                                    </xsl:for-each>
                                                    </ul>
                                                    <p>Lieux</p>
                                                    <ul>
                                                        <xsl:for-each select="//div[@xml:id = 'nicolay1708']//placeName"> <!-- recherche de <placeName> pour les lieux -->
                                                            <li>
                                                                <xsl:value-of select="."/> <!-- valeur de la sélection -->
                                                                <xsl:text> [§</xsl:text>
                                                                <xsl:value-of select="parent::p/@n"/> <!-- valeur numérique du paragraphe parent -->
                                                                <xsl:text>]</xsl:text>
                                                            </li>
                                                        </xsl:for-each>
                                                    </ul>
                                                </xsl:when>
                                                <xsl:when test="@n[parent::div] = '2'"> <!-- TEXTE 2 -->
                                                    <p>Personnes</p>
                                                    <ul> <!-- indication que l'on crée une liste à puces -->
                                                        <xsl:for-each select="//div[@xml:id = 'nicolay1785']//persName"> <!-- frecherche de <orgName> pour les organisations -->
                                                            <li>
                                                                <xsl:value-of select="."/> <!-- valeur de la sélection -->
                                                                <xsl:text> [§</xsl:text>
                                                                <xsl:value-of select="parent::p/@n"/> <!-- valeur numérique du paragraphe parent -->
                                                                <xsl:text>]</xsl:text>
                                                            </li>
                                                        </xsl:for-each>
                                                    </ul>
                                                    <p>Organisations religieuses</p> <!-- en-tête de liste -->
                                                    <ul> <!-- indication que l'on crée une liste à puces -->
                                                        <xsl:for-each select="//div[@xml:id = 'nicolay1785']//orgName"> <!-- frecherche de <orgName> pour les organisations -->
                                                            <li>
                                                                <xsl:value-of select="."/> <!-- valeur de la sélection -->
                                                                <xsl:text> [§</xsl:text>
                                                                <xsl:value-of select="parent::p/@n"/> <!-- valeur numérique du paragraphe parent -->
                                                                <xsl:text>]</xsl:text>
                                                            </li>
                                                        </xsl:for-each>
                                                    </ul>
                                                    <p>Lieux</p>
                                                    <ul>
                                                        <xsl:for-each select="//div[@xml:id = 'nicolay1785']//placeName"> <!-- recherche de <placeName> pour les lieux -->
                                                            <li>
                                                                <xsl:value-of select="."/> <!-- valeur de la sélection -->
                                                                <xsl:text> [§</xsl:text>
                                                                <xsl:value-of select="parent::p/@n"/> <!-- valeur numérique du paragraphe parent -->
                                                                <xsl:text>]</xsl:text>
                                                            </li>
                                                        </xsl:for-each>
                                                    </ul>
                                                </xsl:when>
                                                <xsl:when test="@n[parent::div] = '3'"> <!-- TEXTE 3 -->
                                                    <p>Personnes</p>
                                                    <ul> <!-- indication que l'on crée une liste à puces -->
                                                        <xsl:for-each select="//div[@xml:id = 'nicolay1815']//persName"> <!-- frecherche de <orgName> pour les organisations -->
                                                            <li>
                                                                <xsl:value-of select="."/> <!-- valeur de la sélection -->
                                                                <xsl:text> [§</xsl:text>
                                                                <xsl:value-of select="parent::p/@n"/> <!-- valeur numérique du paragraphe parent -->
                                                                <xsl:text>]</xsl:text>
                                                            </li>
                                                        </xsl:for-each>
                                                    </ul>
                                                    <p>Organisations religieuses</p> <!-- en-tête de liste -->
                                                    <ul> <!-- indication que l'on crée une liste à puces -->
                                                        <xsl:for-each select="//div[@xml:id = 'nicolay1815']//orgName"> <!-- frecherche de <orgName> pour les organisations -->
                                                            <li>
                                                                <xsl:value-of select="."/> <!-- valeur de la sélection -->
                                                                <xsl:text> [§</xsl:text>
                                                                <xsl:value-of select="parent::p/@n"/> <!-- valeur numérique du paragraphe parent -->
                                                                <xsl:text>]</xsl:text>
                                                            </li>
                                                        </xsl:for-each>
                                                    </ul>
                                                    <p>Lieux</p>
                                                    <ul>
                                                        <xsl:for-each select="//div[@xml:id = 'nicolay1815']//placeName"> <!-- recherche de <placeName> pour les lieux -->
                                                            <li>
                                                                <xsl:value-of select="."/> <!-- valeur de la sélection -->
                                                                <xsl:text> [§</xsl:text>
                                                                <xsl:value-of select="parent::p/@n"/> <!-- valeur numérique du paragraphe parent -->
                                                                <xsl:text>]</xsl:text>
                                                            </li>
                                                        </xsl:for-each>
                                                    </ul>
                                                </xsl:when>
                                            </xsl:choose>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <div class="div-liens">
                                    <ul class="ul-liens">
                                        <li><a href="index.html">Accéder à l'index</a> |</li> <!-- liens vers l'accueil et l'index -->
                                        <li><a href="home.html">Retour à l'accueil</a></li>
                                    </ul>
                                </div>
                            </div>
                        </main>
                        <hr/>
                        <xsl:copy-of select="$footer"/>
                    </body>
                </html>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
    
    <!-- TEMPLATES SUBALTERNES DES PAGES PRINCIPALES -->
    <!-- ces templates sont simples et sont présentes pour garder la structure originale des textes en paragraphes sans pertes. Les classes spécifiques sont présentes pour les distinguer dans le HTML en cas de besoin -->
    
    <xsl:template match="opener">
        <p class="opener"> <!-- le 'p' écrit en dur évite que XSLT ne copie la balise TEI -->
            <xsl:choose>
                <xsl:when test="./add">
                    <xsl:attribute name="class">add</xsl:attribute> <!-- rajout d'un attribut @class='add' pour la mise en forme css -->
                    <xsl:text>[</xsl:text>
                    <xsl:value-of select=".//date[1]"/>
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select=".//date[2]"/>
                    <xsl:value-of select="./add/text()"/>
                    <xsl:text> (</xsl:text>
                    <xsl:value-of select="replace(./add/@source,'editorialization by','ajouté par')"/> <!-- utilisation de REPLACE() pour passer de l'anglais au français -->
                    <xsl:text>).]</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="."/>
                </xsl:otherwise> <!-- on récupère la valeur textuelle de la balise 'opener' -->
            </xsl:choose>
        </p>
    </xsl:template>
    
    <xsl:template match="p">
        <p> <!-- pareil ici -->
            <xsl:value-of select="."/>
        </p>
    </xsl:template>
    
    <xsl:template match="closer">
        <p class="closer"> <!-- pareil -->
            <xsl:value-of select="."/>
        </p>
    </xsl:template>
    
    <xsl:template match="signed">
        <p class="signed"> <!-- pareil -->
            <xsl:value-of select="."/>
        </p>
    </xsl:template>

    <!-- TEMPLATE DE LA PAGE D'INDEX -->
    <!-- le but de cette dernière page est de fournir un index des noms de personnes, organisations et lieux mentionnés dans l'ensemble des textes -->
    <!-- j'y ai ajouté un retour permettant d'obtenir l'xml:id du texte et de la partie d'origine, ainsi que le paragraphe où la mention est faite -->
    <!-- le code se répète ici. J'ai voulu essayer de faire fonctionner une variable mais n'ai pas su le faire en raison des boucles -->

    <xsl:template name="index">
        <xsl:result-document href="html/index.html" method="html" indent="yes">
            <html lang="fr">
                <xsl:copy-of select="$head"/> <!-- ajout des métadonnées -->
                <body>
                    <xsl:copy-of select="$navbar"/> <!-- ajout de la barre de navigation -->
                    <h2>Index des noms</h2>
                    <!-- PERSONNES -->
                    <h3>Personnes mentionnées dans les documents</h3>
                    <xsl:for-each-group select="//body//persName" group-by="@ref"> <!-- 'for-each-group' sert à regrouper les occurences de 'persName', ici regroupées avec l'attribut @ref -->
                        <ul>
                            <li>
                                <xsl:for-each select="current-group()"> <!-- pour chaque valeur contenue dans le groupe défini plus haut, boucle -->
                                    <p> <!-- création d'un paragraphe par occurence -->
                                        <xsl:value-of select="substring(current-grouping-key(),2)"/> <!-- valeur de @ref. On utilise SUBSTRING() ici pour retirer le # au début -->
                                        <xsl:text> : </xsl:text> <!-- utilisation de xsl:text pour s'assurer que les espaces sont corrects -->
                                        <xsl:value-of select="."/> <!-- valeur de persName -->
                                        <xsl:text> [source : </xsl:text>
                                        <xsl:if test="./ancestor::div/@xml:id='nicolay1708'"><a href="page1.html">M.-E. Nicolay (1708)</a></xsl:if> <!-- création d'un lien vers la page du texte selon l'xml:id -->
                                        <xsl:if test="./ancestor::div/@xml:id='nicolay1785'"><a href="page2.html">A.-J. Nicolay (1785)</a></xsl:if>
                                        <xsl:if test="./ancestor::div/@xml:id='nicolay1815'"><a href="page3.html">P. Potier de Novion (1815)</a></xsl:if>
                                        <xsl:text>, §</xsl:text>
                                        <xsl:value-of select="./ancestor::p/@n"/> <!-- on utilise de nouveau ancestor pour obtenir le numéro du paragraphe -->
                                        <xsl:text>]</xsl:text>
                                    </p>
                                </xsl:for-each>
                            </li>
                        </ul>
                    </xsl:for-each-group>
                    <xsl:for-each-group select="//body//name" group-by="@ref"> <!-- on répète le processus pour la balise 'name' -->
                        <ul>
                            <li>
                                <xsl:for-each select="current-group()"> <!-- même bout de code que plus haut -->
                                    <p>
                                        <xsl:value-of select="substring(current-grouping-key(),2)"/>
                                        <xsl:text> : </xsl:text>
                                        <xsl:value-of select="."/>
                                        <xsl:text> [source : </xsl:text>
                                        <xsl:if test="./ancestor::div/@xml:id='nicolay1708'"><a href="page1.html">M.-E. Nicolay (1708)</a></xsl:if>
                                        <xsl:if test="./ancestor::div/@xml:id='nicolay1785'"><a href="page2.html">A.-J. Nicolay (1785)</a></xsl:if>
                                        <xsl:if test="./ancestor::div/@xml:id='nicolay1815'"><a href="page3.html">P. Potier de Novion (1815)</a></xsl:if>
                                        <xsl:text>, §</xsl:text>
                                        <xsl:value-of select="./ancestor::p/@n"/>
                                        <xsl:text>]</xsl:text>
                                    </p>
                                </xsl:for-each>
                            </li>
                        </ul>
                    </xsl:for-each-group>
                    <hr/>
                    <!-- ORGANISATIONS -->
                    <h3>Organisations mentionnées dans les documents</h3>
                    <xsl:for-each-group select="//body//orgName" group-by="@ref"> <!-- répétition de nouveau, cette fois pour les noms d'organisations -->
                        <ul>
                            <li>
                                <xsl:for-each select="current-group()">
                                    <p>
                                        <xsl:value-of select="substring(current-grouping-key(),2)"/>
                                        <xsl:text> : </xsl:text>
                                        <xsl:value-of select="."/>
                                        <xsl:text> [source : </xsl:text>
                                        <xsl:if test="./ancestor::div/@xml:id='nicolay1708'"><a href="page1.html">M.-E. Nicolay (1708)</a></xsl:if>
                                        <xsl:if test="./ancestor::div/@xml:id='nicolay1785'"><a href="page2.html">A.-J. Nicolay (1785)</a></xsl:if>
                                        <xsl:if test="./ancestor::div/@xml:id='nicolay1815'"><a href="page3.html">P. Potier de Novion (1815)</a></xsl:if>
                                        <xsl:value-of select="./ancestor::p/@n"/>
                                        <xsl:text>]</xsl:text>
                                    </p>
                                </xsl:for-each>
                            </li>
                        </ul>
                    </xsl:for-each-group>
                    <hr/>
                    <!-- LIEUX -->
                    <h3>Lieux mentionnés dans les documents</h3>
                    <xsl:for-each-group select="//body//placeName" group-by="@ref"> <!-- dernière répétition pour les noms de lieux -->
                        <ul>
                            <li>
                                <xsl:for-each select="current-group()">
                                    <p>
                                        <xsl:value-of select="substring(current-grouping-key(),2)"/>
                                        <xsl:text> : </xsl:text>
                                        <xsl:value-of select="."/>
                                        <xsl:text> [source : </xsl:text>
                                        <xsl:if test="./ancestor::div/@xml:id='nicolay1708'"><a href="page1.html">M.-E. Nicolay (1708)</a></xsl:if>
                                        <xsl:if test="./ancestor::div/@xml:id='nicolay1785'"><a href="page2.html">A.-J. Nicolay (1785)</a></xsl:if>
                                        <xsl:if test="./ancestor::div/@xml:id='nicolay1815'"><a href="page3.html">P. Potier de Novion (1815)</a></xsl:if>
                                        <xsl:text>, §</xsl:text>
                                        <xsl:value-of select="./ancestor::p/@n"/>
                                        <xsl:text>]</xsl:text>
                                    </p>
                                </xsl:for-each>
                            </li>
                        </ul>
                    </xsl:for-each-group>
                    <p><a href="home.html">Retour à l'accueil</a></p> <!-- lien pour revenir à l'accueil -->
                    <hr/>
                    <xsl:copy-of select="$footer"/> <!-- ajout du footer pour avoir la mention finale -->
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>



</xsl:stylesheet>
