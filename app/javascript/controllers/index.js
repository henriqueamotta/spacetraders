// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

import CheckoutController from "./checkout_controller";

const application = Application.start();

// Registra o controlador de checkout
application.register("checkout", CheckoutController);
