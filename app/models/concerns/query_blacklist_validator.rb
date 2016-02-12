class QueryBlacklistValidator < ActiveModel::Validator
  WORDS = /update|delete|insert|drop|;|table/

  def validate(record)
    criteria = record.criteria.to_s
    unless criteria.downcase.scan(WORDS).blank?
      record.errors[:criteria] << I18n.t('query_segment.invalid_words')
    end
  end
end