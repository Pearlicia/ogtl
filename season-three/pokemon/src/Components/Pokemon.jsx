import React, { useEffect, useState } from "react";
import { Typography, Box, Link, Tabs, CircularProgress, Button } from "@material-ui/core";
import Tab from '@material-ui/core/Tab';
import TabPanel from '@material-ui/lab/TabPanel';
import TabContext from '@material-ui/lab/TabContext';
import { toFirstCharUppercase } from "./constants";
import axios from "axios";
import { useParams, useNavigate } from 'react-router-dom';
import '../App.css';

const Pokemon = (props) => {
  const params = useParams();
  const navigate = useNavigate();
  const { pokemonId } = params;
  const [pokemon, setPokemon] = useState(undefined);

  const [toggle, setToggle] = useState(1);

  function updateToggle(id) {
    setToggle(id)
  }

  useEffect(() => {
    axios
      .get(`https://pokeapi.co/api/v2/pokemon/${pokemonId}/`)
      .then(function (response) {
        const { data } = response;
        setPokemon(data);
      })
      .catch(function (error) {
        setPokemon(false);
      });
  }, [pokemonId]);

  const generatePokemonJSX = (pokemon) => {
    const { name, id, species, height, weight, types, moves, stats, abilities, sprites } = pokemon;
    const fullImageUrl = `https://pokeres.bastionbot.org/images/pokemon/${id}.png`;
    const { front_default } = sprites;
    return (
      <>
        <Typography variant="h2">
          {`${id}.`} {toFirstCharUppercase(name)}
        </Typography>
        <img style={{ width: "300px", height: "300px" }} src={front_default} />
        <Typography variant="h3">Pokemon Info</Typography>

       <TabContext>
          <Box sx={{ borderBottom: 3, borderColor: 'divider' }}>
              <Tabs>
                <Tab label="About" onClick={()=>updateToggle(1)} />
                <Tab label="Base Stats" onClick={()=>updateToggle(2)} />
                <Tab label="Evolution" onClick={()=>updateToggle(3)} />
                <Tab label="Moves" onClick={()=>updateToggle(4)} />
              </Tabs>
          </Box>
          <TabPanel className={toggle === 1 ? "show-content" : "content"}>
            <Typography>
              {"Species: "}
              <Link href={species.url}>{species.name} </Link>
            </Typography>
            <Typography>Height: {height} </Typography>
            <Typography>Weight: {weight} </Typography>
            <Typography>
              {"Abilities"}
              {abilities.map((ability) => (
              <li key={ability.ability.name}>{ability.ability.name}</li>
            ))}
            </Typography>
          
          </TabPanel>
          <TabPanel className={toggle === 2 ? "show-content" : "content"}>
              {stats.map((stat, index) => (
                <div key={index}>
                  <p>{stat.stat.name}: {stat.base_stat}</p>
                </div>
              ))}

          <Typography variant="h6"> Types:</Typography>
                  {types.map((typeInfo) => {
                    const { type } = typeInfo;
                    const { name } = type;
                    return <li key={name}> {`${name}`}</li>;
                  })}
          </TabPanel>
          <TabPanel className={toggle === 3 ? "show-content" : "content"}>
            Evolution
          </TabPanel>
          <TabPanel className={toggle === 4 ? "show-content" : "content"}>
              {moves.map(move => (
                <li key={move.move.name}>{move.move.name}</li>
              ))}
          </TabPanel>

       </TabContext>
        
      
      </>
    );
  };

  return (
    <>
      {pokemon === undefined && <CircularProgress />}
      {pokemon !== undefined && pokemon && generatePokemonJSX(pokemon)}
      {pokemon === false && <Typography> Pokemon not found</Typography>}

      {pokemon !== undefined && (
        <Button variant="contained" onClick={() => navigate("/")}>
          back to pokedex
        </Button>
      )}
    </>
  );
};

export default Pokemon;
