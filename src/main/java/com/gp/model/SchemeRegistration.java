package com.gp.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class SchemeRegistration {
    private int id;
    private int schemeId;
    private String schemeName;
    private int citizenId;
    private String citizenName;
    private BigDecimal annualIncome;
    private String occupation;
    private int familyMembers;
    private String remarks;
    private String status;
    private String adminRemarks;
    private Timestamp appliedDate;
    private Timestamp updatedDate;

    public SchemeRegistration() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getSchemeId() { return schemeId; }
    public void setSchemeId(int schemeId) { this.schemeId = schemeId; }

    public String getSchemeName() { return schemeName; }
    public void setSchemeName(String schemeName) { this.schemeName = schemeName; }

    public int getCitizenId() { return citizenId; }
    public void setCitizenId(int citizenId) { this.citizenId = citizenId; }

    public String getCitizenName() { return citizenName; }
    public void setCitizenName(String citizenName) { this.citizenName = citizenName; }

    public BigDecimal getAnnualIncome() { return annualIncome; }
    public void setAnnualIncome(BigDecimal annualIncome) { this.annualIncome = annualIncome; }

    public String getOccupation() { return occupation; }
    public void setOccupation(String occupation) { this.occupation = occupation; }

    public int getFamilyMembers() { return familyMembers; }
    public void setFamilyMembers(int familyMembers) { this.familyMembers = familyMembers; }

    public String getRemarks() { return remarks; }
    public void setRemarks(String remarks) { this.remarks = remarks; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getAdminRemarks() { return adminRemarks; }
    public void setAdminRemarks(String adminRemarks) { this.adminRemarks = adminRemarks; }

    public Timestamp getAppliedDate() { return appliedDate; }
    public void setAppliedDate(Timestamp appliedDate) { this.appliedDate = appliedDate; }

    public Timestamp getUpdatedDate() { return updatedDate; }
    public void setUpdatedDate(Timestamp updatedDate) { this.updatedDate = updatedDate; }
}
