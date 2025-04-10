/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.util.List;
import javax.persistence.Entity;
import javax.persistence.OneToMany;

/**
 *
 * @author FATI
 */
@Entity
public class Touriste extends User {
   
   @OneToMany(mappedBy = "touriste")
private List<ReservationActivity> reservations;

    public Touriste() {
    }


    public Touriste(String nom, String prenom, String email, String motDePasse) {
        super(nom, prenom, email, motDePasse);
    }

    public List<ReservationActivity> getReservations() {
        return reservations;
    }

    public void setReservations(List<ReservationActivity> reservations) {
        this.reservations = reservations;
    }
    
    
}
