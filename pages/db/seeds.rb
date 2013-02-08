#coding: utf-8

domain = nil
if (ENV["new_domain"].present?)
  domain = Refinery::Core::Domain.find_or_create_by_bare_domain(ENV["new_domain"])
  Refinery::Core::BaseModelWithDomain.domain_id = domain.id
end

if Refinery::Page.where(:menu_match => "^/$",:domain_id=>domain.try(:id)).empty?
  home_page = Refinery::Page.create!({:title => "首页",
              :deletable => false,
              :link_url => "/",
              :menu_match => "^/$",
              :domain=>domain
               }

  )
              
  home_page.parts.create({
                :title => "内容",
                :body => "",
                :position => 0
              })

  home_page_position = -1
  page_not_found_page = home_page.children.create(:title => "找不到页面",
              :menu_match => "^/404$",
              :show_in_menu => false,
              :deletable => false)
  page_not_found_page.parts.create({
                :title => "内容",
                :body => "<h2>抱歉,出现一个问题...</h2><p>您访问的页面不存在.</p><p><a href='/'>返回首页</a></p>",
                :position => 0
              })
end


if (header_page=Refinery::Page.find_by_title_and_domain_id("页头", domain.try(:id))).blank?
    header_page = ::Refinery::Page.create!(:title => "页头", 
                                           :domain => domain,
                                           :deletable => false
                                          )
    header_page.parts.create({
      title: "内容",
      position: 1
    })
end

if Refinery::Page.by_title("职位招聘").where(:domain_id=>domain.try(:id)).empty?
  zhaopin_page = header_page.children.create(:title => "职位招聘", :domain=>domain, deletable: false, :link_url => "/sites/position")
                
  zhaopin_page.parts.create({
                :title => "内容",
                :body => "",
                :position => 101
              })
end

if Refinery::Page.by_title("公司动态").where(:domain_id=>domain.try(:id)).empty?
  xinwen_page = header_page.children.create(:title => "公司动态", :domain=>domain, deletable: false, :link_url => "/sites/news")
                
  xinwen_page.parts.create({
                :title => "内容",
                :body => "",
                :position => 102
              })
end


if (footer_page = Refinery::Page.find_by_title_and_domain_id("页脚", domain.try(:id))).blank?
    footer_page = ::Refinery::Page.create!(:title => "页脚", 
                                           :domain => domain,
                                           :deletable => false
                                          )
    footer_page.parts.create({
      title: "内容",
      position: 2
    })
end


if (about_us_page = Refinery::Page.find_by_title_and_domain_id("关于我们", domain.try(:id))).blank?
  about_us_page = footer_page.children.create(:title => "关于我们", :domain=>domain)
  about_us_page.parts.create({
                :title => "内容",
                :body => "",
                :position => 201
              })
end

if Refinery::Page.by_title("愿景与使命").where(domain_id: domain.try(:id)).empty?
  about_us_page1 = about_us_page.children.create(:title => "愿景与使命", :domain=>domain)
  about_us_page1.parts.create({
                :title => "内容",
                :body => "",
                :position => 202
              })
end

if Refinery::Page.by_title("公司战略").where(domain_id: domain.try(:id)).empty?
  about_us_page2 = about_us_page.children.create(:title => "公司战略", :domain=>domain)
  about_us_page2.parts.create({
                :title => "内容",
                :body => "",
                :position => 203
              })
end

if Refinery::Page.by_title("社会责任").where(domain_id: domain.try(:id)).empty?
  about_us_page3 = about_us_page.children.create(:title => "社会责任", :domain=>domain)
  about_us_page3.parts.create({
                :title => "内容",
                :body => "",
                :position => 204
              })
end

if Refinery::Page.by_title("发展历程").where(domain_id: domain.try(:id)).empty?
  about_us_page4 = about_us_page.children.create(:title => "发展历程", :domain=>domain)
  about_us_page4.parts.create({
                :title => "内容",
                :body => "",
                :position => 205
              })
end



if Refinery::Page.by_title("联系我们").where(:domain_id=>domain.try(:id)).empty?
  contact_page = footer_page.children.create(:title => "联系我们",:domain=>domain)
  contact_page.parts.create({
                                 :title => "内容",
                                 :body => "",
                                 :position => 206
                             })

end

if Refinery::Page.by_title("公司团队").where(:domain_id=>domain.try(:id),).empty?
  team_page = footer_page.children.create(:title => "公司团队",:domain=>domain)

  team_page.parts.create({
                                 :title => "内容",
                                 :body => "",
                                 :position => 207
                             })
end

if Refinery::Page.by_title("合作伙伴").where(:domain_id=>domain.try(:id),).empty?
  partners_page = footer_page.children.create(:title => "合作伙伴",:domain=>domain)

  partners_page.parts.create({
                                 :title => "内容",
                                 :body => "",
                                 :position => 208
                             })
end

if Refinery::Page.by_title("客户声音").where(:domain_id=>domain.try(:id),).empty?
  kehushengying_page = footer_page.children.create(:title => "客户声音",:domain=>domain)

  kehushengying_page.parts.create({
                                 :title => "内容",
                                 :body => "",
                                 :position => 209
                             })
end

if Refinery::Page.by_title("常见问题").where(:domain_id=>domain.try(:id),).empty?
  problem_page = footer_page.children.create(:title => "常见问题",:domain=>domain)

  problem_page.parts.create({
                                 :title => "内容",
                                 :body => "",
                                 :position => 210
                             })
end


  (Refinery.i18n_enabled? ? Refinery::I18n.frontend_locales : [:en]).each do |lang|
  I18n.locale = lang
  {'首页' => "首页",
   '找不到页面' => '找不到页面',
   '关于我们' => '关于我们',
   '联系我们'=>"联系我们",
   '公司团队' => "公司团队",
   "合作伙伴" => "合作伙伴",
   "客户声音" => "客户声音",
   '常见问题'=>'常见问题'
  }.each do |slug, title|
    Refinery::Page.by_title(title).each { |page| page.update_attributes(:slug => slug) }
  end
  end
