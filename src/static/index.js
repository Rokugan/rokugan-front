// pull in desired CSS/SASS files
import 'normalize-css'
import './styles/main.scss'

// Import Elm
import Elm from '../elm/Main'

// Do stuff
const app = Elm.Main.embed(document.getElementById('app'))
