/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;


import entities.Touriste;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

/**
 *
 * @author FATI
 */
public class TouristeDao extends AbstractDao<Touriste> {

    public TouristeDao() {
        super(Touriste.class);
    }
    
}