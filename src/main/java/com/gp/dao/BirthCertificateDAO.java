package com.gp.dao;

import com.gp.model.BirthCertificate;
import com.gp.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BirthCertificateDAO {

    public boolean apply(BirthCertificate bc) {
        String sql = "INSERT INTO birth_certificates (citizen_id, child_name, date_of_birth, place_of_birth, father_name, mother_name, father_occupation, mother_occupation, address) VALUES (?,?,?,?,?,?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bc.getCitizenId());
            ps.setString(2, bc.getChildName());
            ps.setDate(3, bc.getDateOfBirth());
            ps.setString(4, bc.getPlaceOfBirth());
            ps.setString(5, bc.getFatherName());
            ps.setString(6, bc.getMotherName());
            ps.setString(7, bc.getFatherOccupation());
            ps.setString(8, bc.getMotherOccupation());
            ps.setString(9, bc.getAddress());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    public List<BirthCertificate> getByCitizenId(int citizenId) {
        List<BirthCertificate> list = new ArrayList<>();
        String sql = "SELECT bc.*, u.full_name as citizen_name FROM birth_certificates bc JOIN users u ON bc.citizen_id=u.id WHERE bc.citizen_id=? ORDER BY bc.applied_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, citizenId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapBC(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public List<BirthCertificate> getAll() {
        List<BirthCertificate> list = new ArrayList<>();
        String sql = "SELECT bc.*, u.full_name as citizen_name FROM birth_certificates bc JOIN users u ON bc.citizen_id=u.id ORDER BY bc.applied_date DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(mapBC(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public List<BirthCertificate> getByStatus(String status) {
        List<BirthCertificate> list = new ArrayList<>();
        String sql = "SELECT bc.*, u.full_name as citizen_name FROM birth_certificates bc JOIN users u ON bc.citizen_id=u.id WHERE bc.status=? ORDER BY bc.applied_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapBC(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public BirthCertificate getById(int id) {
        String sql = "SELECT bc.*, u.full_name as citizen_name FROM birth_certificates bc JOIN users u ON bc.citizen_id=u.id WHERE bc.id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapBC(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public boolean updateStatus(int id, String status, String remarks) {
        String sql = "UPDATE birth_certificates SET status=?, admin_remarks=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setString(2, remarks);
            ps.setInt(3, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    public int countByStatus(String status) {
        String sql = "SELECT COUNT(*) FROM birth_certificates WHERE status=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    private BirthCertificate mapBC(ResultSet rs) throws SQLException {
        BirthCertificate bc = new BirthCertificate();
        bc.setId(rs.getInt("id"));
        bc.setCitizenId(rs.getInt("citizen_id"));
        bc.setCitizenName(rs.getString("citizen_name"));
        bc.setChildName(rs.getString("child_name"));
        bc.setDateOfBirth(rs.getDate("date_of_birth"));
        bc.setPlaceOfBirth(rs.getString("place_of_birth"));
        bc.setFatherName(rs.getString("father_name"));
        bc.setMotherName(rs.getString("mother_name"));
        bc.setFatherOccupation(rs.getString("father_occupation"));
        bc.setMotherOccupation(rs.getString("mother_occupation"));
        bc.setAddress(rs.getString("address"));
        bc.setStatus(rs.getString("status"));
        bc.setAdminRemarks(rs.getString("admin_remarks"));
        bc.setAppliedDate(rs.getTimestamp("applied_date"));
        bc.setUpdatedDate(rs.getTimestamp("updated_date"));
        return bc;
    }
}
