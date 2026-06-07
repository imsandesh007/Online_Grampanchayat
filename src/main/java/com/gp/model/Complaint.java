package com.gp.model;

import java.sql.Timestamp;

public class Complaint {
    private int id;
    private int citizenId;
    private String citizenName;
    private String category;
    private String subject;
    private String description;
    private String location;
    private String status;
    private String adminRemarks;
    private Timestamp filedDate;
    private Timestamp updatedDate;

    public Complaint() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getCitizenId() { return citizenId; }
    public void setCitizenId(int citizenId) { this.citizenId = citizenId; }

    public String getCitizenName() { return citizenName; }
    public void setCitizenName(String citizenName) { this.citizenName = citizenName; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getSubject() { return subject; }
    public void setSubject(String subject) { this.subject = subject; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getAdminRemarks() { return adminRemarks; }
    public void setAdminRemarks(String adminRemarks) { this.adminRemarks = adminRemarks; }

    public Timestamp getFiledDate() { return filedDate; }
    public void setFiledDate(Timestamp filedDate) { this.filedDate = filedDate; }

    public Timestamp getUpdatedDate() { return updatedDate; }
    public void setUpdatedDate(Timestamp updatedDate) { this.updatedDate = updatedDate; }
}
