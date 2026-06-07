package com.gp.model;

import java.sql.Date;
import java.sql.Timestamp;

public class DeathCertificate {
    private int id;
    private int citizenId;
    private String citizenName;
    private String deceasedName;
    private Date dateOfDeath;
    private String placeOfDeath;
    private String causeOfDeath;
    private int ageAtDeath;
    private String relationWithApplicant;
    private String address;
    private String status;
    private String adminRemarks;
    private Timestamp appliedDate;
    private Timestamp updatedDate;

    public DeathCertificate() {}

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getCitizenId() { return citizenId; }
    public void setCitizenId(int citizenId) { this.citizenId = citizenId; }

    public String getCitizenName() { return citizenName; }
    public void setCitizenName(String citizenName) { this.citizenName = citizenName; }

    public String getDeceasedName() { return deceasedName; }
    public void setDeceasedName(String deceasedName) { this.deceasedName = deceasedName; }

    public Date getDateOfDeath() { return dateOfDeath; }
    public void setDateOfDeath(Date dateOfDeath) { this.dateOfDeath = dateOfDeath; }

    public String getPlaceOfDeath() { return placeOfDeath; }
    public void setPlaceOfDeath(String placeOfDeath) { this.placeOfDeath = placeOfDeath; }

    public String getCauseOfDeath() { return causeOfDeath; }
    public void setCauseOfDeath(String causeOfDeath) { this.causeOfDeath = causeOfDeath; }

    public int getAgeAtDeath() { return ageAtDeath; }
    public void setAgeAtDeath(int ageAtDeath) { this.ageAtDeath = ageAtDeath; }

    public String getRelationWithApplicant() { return relationWithApplicant; }
    public void setRelationWithApplicant(String relationWithApplicant) { this.relationWithApplicant = relationWithApplicant; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getAdminRemarks() { return adminRemarks; }
    public void setAdminRemarks(String adminRemarks) { this.adminRemarks = adminRemarks; }

    public Timestamp getAppliedDate() { return appliedDate; }
    public void setAppliedDate(Timestamp appliedDate) { this.appliedDate = appliedDate; }

    public Timestamp getUpdatedDate() { return updatedDate; }
    public void setUpdatedDate(Timestamp updatedDate) { this.updatedDate = updatedDate; }
}
