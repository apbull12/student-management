module StudentsHelper
  def self.existing_subject(params)
    student = Student.find_by(name: params['name'], subject: params['subject'], user_id: params['user_id'])
    return false unless student.present?
    existing_marks = student.mark.present? ? student.mark : 0
    student.update_attributes(mark: existing_marks + params['mark'].to_i)
#     logger.debug "The Existing Student Marks updated before - #{params} after - #{student.attributes}
# and now the user is going to be redirected..."
  end
end
