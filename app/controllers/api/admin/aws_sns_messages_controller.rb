class Api::Admin::AwsSnsMessagesController < Api::Admin::BaseController
  PERMITTED_HEADERS = [
    "HTTP_X_AMZ_SNS_MESSAGE_TYPE",
    "HTTP_X_AMZ_SNS_MESSAGE_ID",
    "HTTP_X_AMZ_SNS_TOPIC_ARN",
    "HTTP_X_AMZ_SNS_SUBSCRIPTION_ARN"
  ]

  def create
    job_adapter.perform_later(permitted_headers, request.raw_post)
    head(:created)
  end

  private

  def job_adapter
    @job_adapter ||= JobAdapter.new(:aws_sns_message_processor_worker)
  end

  def permission_name
    :manage_aws_sns_messages
  end

  def permitted_headers
    request.headers.to_h.slice(*PERMITTED_HEADERS)
  end
end
