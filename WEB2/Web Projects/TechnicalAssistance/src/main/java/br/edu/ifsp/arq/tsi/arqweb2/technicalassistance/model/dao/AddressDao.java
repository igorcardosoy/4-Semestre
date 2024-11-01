package br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.dao;

import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.Address;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Optional;

public class AddressDao {

    private final DataSource dataSource;

    public AddressDao(DataSource dataSource) {
        super();
        this.dataSource = dataSource;
    }

    public Optional<Address> getByCode(Long code) {
        String sql = "select * from address where address_code = ?";
        try(Connection conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)){
            ps.setLong(1, code);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                Address address = new Address();
                address.setCode(rs.getLong("address_code"));
                address.setStreet(rs.getString("street"));
                address.setNumber(rs.getString("number"));
                address.setComplement(rs.getString("complement"));
                address.setNeighborhood(rs.getString("neighborhood"));
                address.setCity(rs.getString("city"));
                address.setState(rs.getString("state"));
                address.setZipCode(rs.getString("zipcode"));
                return Optional.of(address);
            }
        }catch (SQLException e) {
            e.printStackTrace();
            return Optional.empty();
        }

        return Optional.empty();

    }

    public int getLastId() {
        String sql = "select max(code) as id from address";
        try(Connection conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)){
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                return rs.getInt("id");
            }
        }catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }

        return 0;
    }

    public Boolean update(Address address){
        Optional<Address> optional = getByCode(address.getCode());
        if(optional.isEmpty()) {
            return false;
        }

        String sql = "update address set street=?, number=?, complement=?, neighborhood=?, city=?, state=?, zipcode=? where address_code=?";
        try(Connection conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)){
            createAddress(address, ps);
            ps.setLong(8, address.getCode());
            ps.executeUpdate();
        }catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    public Boolean delete(Long code){
        Optional<Address> optional = getByCode(code);
        if(optional.isEmpty()) {
            return false;
        }

        String sql = "delete from address where address_code = ?";
        try(Connection conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)){
            ps.setLong(1, code);
            ps.executeUpdate();
        }catch (SQLException e) {
            throw new RuntimeException("Erro durante a escrita no BD", e);
        }
        return true;
    }

    public Boolean save(Address address){
        Optional<Address> optional = getByCode(address.getCode());
        if(optional.isPresent()) {
            return false;
        }

        String sql = "insert into address (street, number, complement, neighborhood, city, state, zipcode) values (?, ?, ?, ?, ?, ?, ?)";
        try(Connection conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)){
            createAddress(address, ps);
            ps.executeUpdate();
        }catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

        return true;
    }

    private void createAddress(Address address, PreparedStatement ps) throws SQLException {
        ps.setString(1, address.getStreet());
        ps.setString(2, address.getNumber());
        ps.setString(3, address.getComplement());
        ps.setString(4, address.getNeighborhood());
        ps.setString(5, address.getCity());
        ps.setString(6, address.getState());
        ps.setString(7, address.getZipCode());
    }
}
