require 'rails_helper'

describe PhoneCallEvent::Answered do
  let(:factory) { :phone_call_event_answered }
  include_examples("phone_call_event")
end
