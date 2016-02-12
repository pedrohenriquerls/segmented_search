class QueryBlacklistValidator < ActiveModel::Validator
  WORDS = /update|delete|insert|drop|;|table/

  def validate(record)
    params = record.params.to_s
    unless params.downcase.scan(WORDS).blank?
      record.errors[:params] << I18n.t('query_segment.invalid_words')
    end
  end
end