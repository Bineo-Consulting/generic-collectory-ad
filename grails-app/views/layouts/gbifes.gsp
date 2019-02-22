<%--
  Created by IntelliJ IDEA.
  User: SaMa
  Date: 29/7/16
  Time: 18:35
--%>

<g:set var="orgNameLong" value="${grailsApplication.config.skin.orgNameLong}"/>
<g:set var="orgNameShort" value="${grailsApplication.config.skin.orgNameShort}"/>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="app.version" content="${g.meta(name:'app.version')}"/>
    <meta name="app.build" content="${g.meta(name:'app.build')}"/>
    <link rel="shortcut icon" type="image/x-icon" href="favicon.ico">
    <g:if test="${instance}">
        <meta name="description" content="${orgNameLong} description of the ${instance?.name}. ${instance?.makeAbstract(200)}"/>
    </g:if>
    <g:else>
        <meta name="description" content="Explore ${orgNameLong}'s Natural History Collections."/>
    </g:else>
    <title><g:layoutTitle /> | ${orgNameLong}</title>
    <g:render template="/layouts/global"/>
    <r:require modules="jquery, jquery_migration, bootstrap, application, collectory, gbifes" />
    <style type="text/css">
    body {
        background-color: #ffffff !important;
    }
    #breadcrumb {
        margin-top: 10px;
    }
    #footer {
        margin: 20px;
        padding-top: 10px;
        border-top: 1px solid #CCC;
        font-size: 12px;
    }
    #content .nav-tabs > li.active > a {
        background-color: #ffffff;
    }
    .nav {
        margin-top: 20px;
    }
    </style>
    <r:script disposition='head'>
        // initialise plugins
        jQuery(function(){
            // autocomplete on navbar search input
            jQuery("form#search-form-2011 input#search-2011, form#search-inpage input#search, input#search-2013").autocomplete('http://bie.ala.org.au/search/auto.jsonp', {
                extraParams: {limit: 100},
                dataType: 'jsonp',
                parse: function(data) {
                    var rows = new Array();
                    data = data.autoCompleteList;
                    for(var i=0; i<data.length; i++) {
                        rows[i] = {
                            data:data[i],
                            value: data[i].matchedNames[0],
                            result: data[i].matchedNames[0]
                        };
                    }
                    return rows;
                },
                matchSubset: false,
                formatItem: function(row, i, n) {
                    return row.matchedNames[0];
                },
                cacheLength: 10,
                minChars: 3,
                scroll: false,
                max: 10,
                selectFirst: false
            });

            // Mobile/desktop toggle
            // TODO: set a cookie so user's choice is remembered across pages
            var responsiveCssFile = $("#responsiveCss").attr("href"); // remember set href
            $(".toggleResponsive").click(function(e) {
                e.preventDefault();
                $(this).find("i").toggleClass("icon-resize-small icon-resize-full");
                var currentHref = $("#responsiveCss").attr("href");
                if (currentHref) {
                    $("#responsiveCss").attr("href", ""); // set to desktop (fixed)
                    $(this).find("span").html("Mobile");
                } else {
                    $("#responsiveCss").attr("href", responsiveCssFile); // set to mobile (responsive)
                    $(this).find("span").html("Desktop");
                }
            });
            $('.helphover').popover({animation: true, trigger:'hover'});
        });
    </r:script>
    <r:layoutResources/>
    <g:layoutHead />
</head>
<body class="${pageProperty(name:'body.class')?:'nav-collections'}" id="${pageProperty(name:'body.id')}" onload="${pageProperty(name:'body.onload')}">
<div class="navbar navbar-fixed-top" style="margin-bottom: 35px">
    <div class="navbar-inner">
        <div class="container">
            <a class="btn btn-navbar" data-target=".navbar-responsive-collapse" data-toggle="collapse">
                <a class="brand" href="http://datos.gbif.es"><g:message code="header.menu.00" default="Data portal of GBIF Spain"/></a>
                <div class="nav-collapse collapse navbar-responsive-collapse">
                    <ul class="nav">
                        <li class="active">
                            <a href="http://datos.gbif.es"><g:message code="header.menu.01" default="Home"/> </a>
                        </li>
                        <li>
                            <a href="http://datos.gbif.es/collectory/"><g:message code="header.menu.02" default="Institutions, collections and projects"/></a>
                        </li>
                        <li>
                            <a href="http://datos.gbif.es/collectory/datasets/"><g:message code="header.menu.03" default="Datasets"/></a>
                        </li>
                        <li>
                            <a href="http://datos.gbif.es/generic-hub/occurrences/search?q=&buscar_home=#tab_mapView"><g:message code="header.menu.04" default="Georeferenced data"/></a>
                        </li>
                        <li>
                            <a href="http://datos.gbif.es/generic-hub/search#tab_simpleSearch"><g:message code="header.menu.05" default="Search"/></a>
                        </li>
                        <li class="dropdown">
                            <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                www.gbif.es
                                <b class="caret"></b>
                            </a>
                            <ul class="dropdown-menu">
                                <li class="nav-header"><g:message code="header.menu.06.01" default="Registry-Metadata"/></li>
                                <li>
                                    <a href="http://www.gbif.es/ic_BusquedaCentros.php"><g:message code="header.menu.06.02" default="Institutions, projects and centers"/></a>
                                </li>
                                <li>
                                    <a href="http://www.gbif.es/ic_BusquedaColecciones.php"><g:message code="header.menu.06.03" default="Collections and Data bases"/></a>
                                </li>
                                <li>
                                    <a href="http://www.gbif.es/ic_BusquedaPersonas.php"><g:message code="header.menu.06.04" default="People"/></a>
                                </li>
                                <li class="divider"></li>
                                <li class="nav-header"><g:message code="header.menu.06.05" default="Data publication"/></li>
                                <li>
                                    <a href="http://www.gbif.es/guiaIPT.php"><g:message code="header.menu.06.06" default="Publication guide"/></a>
                                </li>
                                <li>
                                    <a href="http://www.gbif.es/ipt"><g:message code="header.menu.06.07" default="IPT"/></a>
                                </li>
                                <li class="divider"></li>
                                <li class="nav-header"><g:message code="header.menu.06.08" default="Training and disclosure"/></li>
                                <li>
                                    <a href="http://www.gbif.es/formacion.php"><g:message code="header.menu.06.09" default="Activities"/></a>
                                </li>
                                <li>
                                    <a href="http://www.gbif.es/videos/videos.php"><g:message code="header.menu.06.10" default="Videos"/></a>
                                </li>
                                <li>
                                    <a href="http://www.gbif.es/Plan_formacion.php"><g:message code="header.menu.06.11" default="Annual training plan"/></a>
                                </li>
                                <li class="divider"></li>
                                <li class="nav-header"><g:message code="header.menu.06.12" default="News and events"/></li>
                                <li>
                                    <a href="http://www.gbif.es/noticias.php"><g:message code="header.menu.06.13" default="News"/></a>
                                </li>
                                <li>
                                    <a href="http://www.gbif.es/eventos.php"><g:message code="header.menu.06.14" default="Events"/></a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                    %{--}<form class="navbar-search pull-left" name="simpleSearchForm" id="simpleSearchForm" action="${request.contextPath}/occurrences/search" method="GET">
                        <input class="search-query span2" type="text" placeholder="Search">
                    </form>--}%
                    <ul  class="nav pull-right">


                        <li class="dropdown" style="margin-left: 5px">
                            <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                <g:message code="header.menu.07" default="Language"/>
                                <b class="caret"></b>
                            </a>
                            <ul class="dropdown-menu">
                                <li style="margin-left: 20px">
                                    <langs:selector langs="ca"/>
                                </li>
                                <li style="margin-left: 20px">
                                    <langs:selector langs="en"/>
                                </li>
                                <li style="margin-left: 20px">
                                    <langs:selector langs="es"/>
                                </li>
                            </ul>
                        </li>
                        <li class="divider-vertical"></li>
                        <li>
                            <a href="https://goo.gl/HeJU4w"><g:message code="header.menu.08" default="Help"/></a>
                        </li>
                    </ul>
                </div>
        </div>
    </div>
</div>
<div class="container" id="main-content">
    <g:layoutBody />
</div><!--/.container-->
<footer class="footer">
    <div class="container">

        <!-- Example row of columns -->
        <div class="row">
            <div class="span4"> <div class="aviso"><r:img dir="images" file="ico-aviso.png" alt="Aviso" /><g:message code="footer.aviso.01" default="Estamos ajustando algunas funcionalidades del portal. Disculpe las molestias que esto pueda ocasionar. Si observa cualquier incidencia agradeceríamos que nos la comunicase mediante  mensaje a"/> <a href="mailto:feedback@gbif.es">feedback@gbif.es</a></div>
                <p><g:message code="footer.aviso.02" default=""/> <strong><g:message code="footer.aviso.03" default=""/></strong>, <g:message code="footer.aviso.04" default=""/> <br />
                    <g:message code="footer.aviso.05" default=""/>.</p>
                <p>®<u><a href="http://creativecommons.org/licenses/by/3.0/es/" target="_blank"><g:message code="footer.aviso.06" default=""/></a></u>. <g:message code="footer.aviso.07" default=""/> </p>
            </div><br>

            <div class="span4">
                <p><strong><g:message code="footer.menu.01" default="CONTACT"/></strong><br />
                    GBIF España. Unidad de Coordinación<br />
                    Real Jardín Botánico - CSIC<br />
                    C/ Claudio Moyano, 1<br />
                    28014 MADRID - España<br />
                    Tel.: 34 914203017 extensión 273<br />
                    <a href="mailto:info@gbif.es">info@gbif.es</a></p>
                <p>
                    <a href="http://www.gbif.es/rss.php"><r:img dir="images" file="rss.png" /></a>
                    <a href="https://twitter.com/GbifEs"><r:img dir="images" file="twitter.png" /></a>
                    <a href="https://github.com/GBIFes/"><r:img dir="images" file="github.png" /></a>
                </p>
                <p><strong><g:message code="footer.menu.02" default="DATA"/></strong><br />
                    <a href="http://datos.gbif.es/collectory/"><g:message code="footer.menu.02.01" default="Institutions, collections and projects"/></a><br />
                    <a href="http://datos.gbif.es/collectory/datasets/"><g:message code="footer.menu.02.02" default="Datasets"/></a><br />
                    <a href="http://datos.gbif.es/generic-hub/explore/your-area?default=true"><g:message code="footer.menu.02.03" default="Explore your area"/></a><br />
                    <a href="http://datos.gbif.es/generic-hub/search#tab_simpleSearch"><g:message code="footer.menu.02.04" default="Search"/></a></p>
            </div>

            <div class="span4">
                <p><strong><g:message code="footer.menu.03" default="SERVICES"/></strong><br />
                    <a href="http://www.gbif.es/ipt/"><g:message code="footer.menu.03.01" default="Publication and hosting of data: IPT"/></a><br />
                    <a href="http://www.gbif.es/Alojamiento/ImagenesIndex.php"><g:message code="footer.menu.03.02" default="Hosting of images"/></a><br />
                    <a href="http://www.gbif.es/formacion.php"><g:message code="footer.menu.03.03" default="Training"/></a></p>
                <p><strong>SOFTWARE</strong><br />
                    <a href="http://www.gbif.es/herbar/herbar.php">Herbar</a> |  <a href="http://www.gbif.es/zoorbar/zoorbar.php">Zoorbar</a> |  <a href="http://www.gbif.es/hzl/hzl.php">HZL</a> |  <a href="http://www.gbif.es/darwin_test/Darwin_Test.php">Darwin Test</a></p>
                <p><strong><g:message code="footer.menu.04" default="Resources"/></strong><br />
                    <a href="<g:if test="${lang == 'es'}">http://www.gbif.es/Recursos.php#tabs-5</g:if><g:else>http://www.gbif.es/Recursos_in.php#tabs-5</g:else>"><g:message code="footer.menu.04.01" default="Terms of use"/></a><br />
                    <a href="<g:if test="${lang == 'es'}">http://www.gbif.es/Recursos.php#tabs-4></g:if><g:else>http://www.gbif.es/Recursos_in.php#tabs-4</g:else>"><g:message code="footer.menu.04.02" default="Publication and hosting of data: IPT"/></a><br />
                    <a href="<g:if test="${lang == 'es'}">http://www.gbif.es/Recursos.php#tabs-2></g:if><g:else>http://www.gbif.es/Recursos_in.php#tabs-2</g:else>"><g:message code="footer.menu.04.03" default="Usage of scanned images"/></a><br />
                    <a href="<g:if test="${lang == 'es'}">http://www.gbif.es/Recursos.php#tabs-4></g:if><g:else>http://www.gbif.es/Recursos_in.php#tabs-4</g:else>"><g:message code="footer.menu.04.04" default="Sensitive data"/></a><br />
                    <a href="<g:if test="${lang == 'es'}">http://www.gbif.es/Recursos.php#tabs-6></g:if><g:else>http://www.gbif.es/Recursos_in.php#tabs-6</g:else>"><g:message code="footer.menu.04.05" default="GBIF guides"/></a></p>
            </div>
        </div>
    </div>

</footer>

<div class="footer bottom">
    <a href="http://www.ala.org.au/" target="_blank"><r:img dir="images" file="ala-logo.jpg" alt="Atlas  of Living Australia" title="Atlas  of Living Australia"/></a>
    %{--<r:img dir="images" file="mineco_logo.jpg" Alt="MINECO" title="MINECO" usemap="#map"/>
    <map name="Map">
        <area shape="rect" coords="201,15,337,67" href="http://www.csic.es/ " target="_blank" alt="www.csic.es">
        <area shape="rect" coords="7,17,197,68" href="http://www.mineco.gob.es/" target="_blank" alt="	http://www.mineco.gob.es">
    </map>--}%
    <a href="http://www.rjb.csic.es/jardinbotanico/jardin/" target="_blank"><r:img dir="images" file="LOGO-GOB_MEC_CSIC_RJB.jpg"  height="20%" width="20%" alt="Real Jardín Botánico de Madrid" title="Real Jardín Botánico de Madrid"/></a>
    <a href="http://www.gbif.es/" target="_blank"><r:img dir="images" file="GBIF-ES.png" height="8%" width="8%" alt="GBIF.es" title="GBIF España"/></a>
    <a href="http://www.gbif.org/" target="_blank"><r:img dir="images" file="gbif-org_logo.jpg" alt="GBIF" title="GBIF"/></a>
    <a href="http://www.ifca.unican.es/" target="_blank"><r:img dir="images" file="ifca-logo.jpg" alt="Instituto de Física de Cantabria" title="Instituto de Física de Cantabria"/></a>
    <a href="https://crowdin.com/ " target="_blank"><r:img dir="images" file="crowdin-logo.jpg" alt="crowdin" title="crowdin"/></a>
</div>
<!-- JS resources-->
<r:layoutResources/>
</body>
</html>