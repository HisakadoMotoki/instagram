# frozen_string_literal: true

module NotificationsHelper
  def notification_form(notification)
    @comment = nil
    visitor = link_to notification.visitor.name, notification.visitor, style: 'font-weight: bold;'
    your_picture = link_to 'あなたの投稿', notification.picture, style: 'font-weight: bold;'
    case notification.action
    when 'follow'
      "#{visitor}があなたをフォローしました"
    when 'favorite'
      "#{visitor}が#{your_picture}にいいね！しました"
    when 'comment'
      # @comment = Comment.find_by(id:notification.comment_id)&.content
      "#{visitor}が#{your_picture}にコメントしました"
      end
  end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end
