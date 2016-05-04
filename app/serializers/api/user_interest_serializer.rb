class Api::UserInterestSerializer < Api::BaseSerializer
  attributes :id, :intererst_category_id, :sub_category, :interest_name, :user_id, :created_at, :updated_at
end
