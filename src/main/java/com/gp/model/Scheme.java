package com.gp.model;

import java.sql.Date;
import java.sql.Timestamp;

public class Scheme {
    private int id;
    private String schemeName;
    private String description;
    private String eligibility;
    private String benefits;
    private Date lastDate;
    private String status;
    private Timestamp createdAt;

    public Scheme() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getSchemeName() { return schemeName; }
    public void setSchemeName(String schemeName) { this.schemeName = schemeName; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getEligibility() { return eligibility; }
    public void setEligibility(String eligibility) { this.eligibility = eligibility; }

    public String getBenefits() { return benefits; }
    public void setBenefits(String benefits) { this.benefits = benefits; }

    public Date getLastDate() { return lastDate; }
    public void setLastDate(Date lastDate) { this.lastDate = lastDate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
