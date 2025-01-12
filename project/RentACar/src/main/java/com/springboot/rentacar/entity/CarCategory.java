package com.springboot.rentacar.entity;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class CarCategory {
    @Id
    private int id;

    @Column(nullable = false)
    private String category_name;

    @OneToMany(mappedBy = "carCategory", cascade = CascadeType.ALL)
    @JsonIgnoreProperties("carCategory")
    private List<Cars> cars;

}
