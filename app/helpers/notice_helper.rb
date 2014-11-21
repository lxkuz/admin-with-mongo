module NoticeHelper
  def render_notice
    return unless flash[:notice].present?
    capture do
      content_tag :div, class: 'notice' do
        concat flash[:notice]
      end
    end
  end
end
