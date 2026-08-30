import { JobApplication, Job, Company } from "./schemas.js";
import mg from 'mongoose'

const jobApplication = await JobApplication.create({
    applicantName: "Kumar",
    email: "kumar123@gmail.com",
    jobTitle: "developer",
    salary: "10000",
    appliedAt: new Date('2025-05-22'),
    status: "pending"
})

// get all job applications
await JobApplication.find()

//find 1 job from email
await JobApplication.findOne({ email: "kumar123@gmail.com" })

//find applications where status is pending 
await JobApplication.find({ status: "pending" })

//update an application status to accepted
await JobApplication.findByIdAndUpdate(id, { status: "accepted" })

//delete an application
await JobApplication.findByIdAndDelete(id)

//application with salary greater than 50000
await JobApplication.find({ salary: { $gt: 50000 } })

await JobApplication.find({ status: { $in: ["pending", "accepted"] } })


//query to find all jobs 

await Job.find().populate('company')


Job.find({ salary: { $gt: 30000, $lt: 80000 } })
Company.findOne({ name: "TCS" })
Job.findByIdAndDelete(id)
Company.findByIdAndUpdate(id, { location: "Pune" })
Job.find({ title: { $in: ["Developer", "Designer"] } })