Sidekiq::Cron::Job.create(name: 'Reviewer Notification worker - every monday', cron: '0 9 * * MON', class: 'ReviewerNotificationWorker')
Sidekiq::Cron::Job.create(name: 'Redactor Notification worker - every day', cron: '0 9 * * *', class: 'RedactorNotificationWorker')
