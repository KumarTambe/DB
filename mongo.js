import mg from 'mongoose'

const jobApplicationSchema = new mg.Schema({
    applicantName: { type: String, required: true },
    email: { type: String, required: true, unique: true },
    jobTitle: { type: String, required: true },
    salary: { type: Number, default: 0 },
    appliedAt: { type: Date, default: Date.now },
    status: { type: String, default: "pending" }
})

const JobApplication = mg.model('JobApplication', jobApplicationSchema)

const companySchema = new mg.Schema({
    companyName: { type: String, required: true },
    location: { type: String }
})

const Company = mg.model('Company', companySchema)

const jobSchema = new mg.Schema({
    title: { type: String, required: true },
    salary: { type: Number },
    company: {
        type: mg.Schema.Types.ObjectId,
        ref: 'Company'
    }
})

const Job = mg.model('Job', jobSchema)

export { JobApplication, Job, Company }
