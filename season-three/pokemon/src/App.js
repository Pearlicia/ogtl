import React from "react";
// import Home from "./Home";
// import Users from "./Users";
// import About from "./About";

import {
  BrowserRouter as Router,
  Routes,
  Route,
} from "react-router-dom";

import Pokedex from "./Components/Pokedex";
import Pokemon from "./Components/Pokemon";

const App = () => {
  return (
    <Router>
      <Routes>
        {/* <Route exact path="/" element={(props) => <Pokedex {...props} />} /> */}
        <Route exact path="/" element={<Pokedex />} />

        {/* <Route
          exact
          path="/:pokemonId"
          element={(props) => <Pokemon {...props} />}
        /> */}
         <Route
          exact
          path="/:pokemonId"
          element={<Pokemon />}
        />
      </Routes>
    </Router>
  );
}
  

export default App;


// export default function App() {
//   return (
//     <Router>
//       <div>
//         <nav>
//           <ul>
//             <li>
//               <Link to="/">Home</Link>
//             </li>
//             <li>
//               <Link to="/about">About</Link>
//             </li>
//             <li>
//               <Link to="/users">Users</Link>
//             </li>
//           </ul>
//         </nav>

//         <Routes>
//           <Route path="/about" element={<About />} />
//           <Route path="/users" element={<Users />} />
//           <Route path="/" element={<Home />} />
//         </Routes>
//       </div>
//     </Router>
//   );
// }