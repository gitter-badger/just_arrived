class JobPerformedAcceptNotifier
  def self.call(job:)
    owner = job.owner
    user = job.accepted_applicant

    UserMailer
      .job_performed_accept_email(user: user, job: job, owner: owner)
      .deliver_later
  end
end
