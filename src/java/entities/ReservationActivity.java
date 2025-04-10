package entities;

import java.time.LocalDate;
import javax.persistence.*;

@Entity
@Table(name = "reservations")
public class ReservationActivity {

    @EmbeddedId
    private ReservationActivityId id;

    @ManyToOne
    @JoinColumn(name = "activite_touriste_id", referencedColumnName = "id", insertable = false, updatable = false)
    private ActiviteTouristique activite;

    @ManyToOne
    @JoinColumn(name = "touriste_id", referencedColumnName = "id", insertable = false, updatable = false)
    private Touriste touriste;
    
    @Column(name = "reservation_date")
    private LocalDate reservationDate;
    
    public ReservationActivity() {
    }

    public ReservationActivity(ActiviteTouristique activite, Touriste touriste, LocalDate reservationDate) {
        this.activite = activite;
        this.touriste = touriste;
        this.reservationDate = reservationDate;
    }

    public ReservationActivityId getId() {
        return id;
    }

    public void setId(ReservationActivityId id) {
        this.id = id;
    }

    public ActiviteTouristique getActivite() {
        return activite;
    }

    public void setActivite(ActiviteTouristique activite) {
        this.activite = activite;
    }

    public Touriste getTouriste() {
        return touriste;
    }

    public void setTouriste(Touriste touriste) {
        this.touriste = touriste;
    }

    public LocalDate getReservationDate() {
        return reservationDate;
    }

    public void setReservationDate(LocalDate reservationDate) {
        this.reservationDate = reservationDate;
    }

}
