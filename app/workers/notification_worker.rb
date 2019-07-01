class NotificationWorker
  include Sidekiq::Worker

  def perform
    @notifications = Task.where(notification_date: Time.now)
    if @notifications.present?
      @notifications.each do |notification|
        fcm = FCM.new('my_server_key')
        registration_ids= ["12", "13"] # an array of one or more client registration tokens

        options = {'notification':
          {
            'title': notification.name,
            'body': notification.description
          }
        }
        response = fcm.send(registration_ids, options)
      end
    end
  end
end
