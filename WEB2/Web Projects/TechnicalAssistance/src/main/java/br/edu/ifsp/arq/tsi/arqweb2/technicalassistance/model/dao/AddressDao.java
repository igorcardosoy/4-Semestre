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

    public Optional<Address> getAddressById(Long id) {
        String sql = "select * from ADDRESS where id = ?";
        try(Connection conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)){
            ps.setLong(1, id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                Address address = new Address();
                address.setId(rs.getLong("id"));
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
            throw new RuntimeException("Erro durante a leitura no BD", e);
        }
        return Optional.empty();

    }

    public int getLastId() {
        String sql = "select max(id) as id from ADDRESS";
        try(Connection conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)){
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                return rs.getInt("id");
            }
        }catch (SQLException e) {
            throw new RuntimeException("Erro durante a leitura no BD", e);
        }

        return 0;
    }

    public Boolean save(Address address){
        Optional<Address> optional = getAddressById(address.getId());
        if(optional.isPresent()) {
            return false;
        }

        String sql = "insert into ADDRESS (street, number, complement, neighborhood, city, state, zipcode) values (?, ?, ?, ?, ?, ?, ?)";
        try(Connection conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)){
            ps.setString(1, address.getStreet());
            ps.setString(2, address.getNumber());
            ps.setString(3, address.getComplement());
            ps.setString(4, address.getNeighborhood());
            ps.setString(5, address.getCity());
            ps.setString(6, address.getState());
            ps.setString(7, address.getZipCode());
            ps.executeUpdate();
        }catch (SQLException e) {
            throw new RuntimeException("Erro durante a escrita no BD", e);
        }
        return true;
    }
}
