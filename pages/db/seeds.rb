domain = nil
if (ENV["new_domain"].present?)
  domain = Refinery::Core::Domain.find_or_create_by_bare_domain(ENV["new_domain"])
  Refinery::Core::BaseModelWithDomain.domain_id = domain.id
end
if Refinery::Page.where(:menu_match => "^/$",:domain_id=>domain.try(:id)).empty?
  home_page = Refinery::Page.create!({:title => "Home",
              :deletable => false,
              :link_url => "/",
              :menu_match => "^/$",
              :domain=>domain
               }

  )
              
  home_page.parts.create({
                :title => "Body",
                :body => "<p>Welcome to our site. This is just a place holder page while we gather our content.</p>",
                :position => 0
              })
  home_page.parts.create({
                :title => "Side Body",
                :body => "<p>This is another block of content over here.</p>",
                :position => 1
              })

  home_page_position = -1
  page_not_found_page = home_page.children.create(:title => "Page not found",
              :menu_match => "^/404$",
              :show_in_menu => false,
              :deletable => false)
  page_not_found_page.parts.create({
                :title => "Body",
                :body => "<h2>Sorry, there was a problem...</h2><p>The page you requested was not found.</p><p><a href='/'>Return to the home page</a></p>",
                :position => 0
              })
end

if Refinery::Page.by_title("About").where(:domain_id=>domain.try(:id),).empty?
  about_us_page = ::Refinery::Page.create(:title => "About",:domain=>domain)

  about_us_page.parts.create({
                :title => "Body",
                :body => "<p>This is just a standard text page example. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin metus dolor, hendrerit sit amet, aliquet nec, posuere sed, purus. Nullam et velit iaculis odio sagittis placerat. Duis metus tellus, pellentesque ut, luctus id, egestas a, lorem. Praesent vitae mauris. Aliquam sed nulla. Sed id nunc vitae leo suscipit viverra. Proin at leo ut lacus consequat rhoncus. In hac habitasse platea dictumst. Nunc quis tortor sed libero hendrerit dapibus.\n\nInteger interdum purus id erat. Duis nec velit vitae dolor mattis euismod. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Suspendisse pellentesque dignissim lacus. Nulla semper euismod arcu. Suspendisse egestas, erat a consectetur dapibus, felis orci cursus eros, et sollicitudin purus urna et metus. Integer eget est sed nunc euismod vestibulum. Integer nulla dui, tristique in, euismod et, interdum imperdiet, enim. Mauris at lectus. Sed egestas tortor nec mi.</p>",
                :position => 0
              })
  about_us_page.parts.create({
                :title => "Side Body",
                :body => "<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus fringilla nisi a elit. Duis ultricies orci ut arcu. Ut ac nibh. Duis blandit rhoncus magna. Pellentesque semper risus ut magna. Etiam pulvinar tellus eget diam. Morbi blandit. Donec pulvinar mauris at ligula. Sed pellentesque, ipsum id congue molestie, lectus risus egestas pede, ac viverra diam lacus ac urna. Aenean elit.</p>",
                :position => 1
              })
end

(Refinery.i18n_enabled? ? Refinery::I18n.frontend_locales : [:en]).each do |lang|
  I18n.locale = lang
  {'home' => "Home",
   'page-not-found' => 'Page not found',
   'about' => 'About',
   'problem'=>'Problem',
   'contact'=>"Contact"
  }.each do |slug, title|
    Refinery::Page.by_title(title).each { |page| page.update_attributes(:slug => slug) }
  end
end

  if Refinery::Page.by_title("Contact").where(:domain_id=>domain.try(:id),).empty?
    contact_page = ::Refinery::Page.create(:title => "Contact",:domain=>domain)

    contact_page.parts.create({
                                   :title => "Body",
                                   :body => "<p>contact</p>",
                                   :position => 0
                               })
    contact_page.parts.create({
                                   :title => "Side Body",
                                   :body => "<p>contact_side.</p>",
                                   :position => 1
                               })
  end

  if Refinery::Page.by_title("Problem").where(:domain_id=>domain.try(:id),).empty?
    problem_page = ::Refinery::Page.create(:title => "Problem",:domain=>domain)

    problem_page.parts.create({
                                   :title => "Body",
                                   :body => "<p>problem</p>",
                                   :position => 0
                               })
    problem_page.parts.create({
                                   :title => "Side Body",
                                   :body => "<p>problem_side</p>",
                                   :position => 1
                               })
  end

