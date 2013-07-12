module ApplicationHelper
  def html_tag_with_browser_classes( lang = "en", &block )
    haml_concat Haml::Util::html_safe <<-"HTML".gsub( /^\s+/, '' )
      <!--[if lt IE 7 ]><html lang="#{lang}" class="ie ie6"> <![endif]-->
      <!--[if IE 7 ]>   <html lang="#{lang}" class="ie ie7"> <![endif]-->
      <!--[if IE 8 ]>   <html lang="#{lang}" class="ie ie8"> <![endif]-->
      <!--[if IE 9 ]>   <html lang="#{lang}" class="ie ie9"> <![endif]-->
      <!--[if (gte IE 9)|!(IE)]><!--> <html lang="#{lang}"> <!--<![endif]-->
    HTML
    haml_concat capture( &block ) << Haml::Util::html_safe( "\n</html>" ) if block_given?
  end
end
