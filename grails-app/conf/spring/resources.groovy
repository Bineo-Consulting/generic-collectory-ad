import au.org.ala.collectory.ExtendedPluginAwareResourceBundleMessageSource
import org.springframework.web.servlet.i18n.SessionLocaleResolver

// Place your Spring DSL code here
beans = {
    // Custom message source
    messageSource(ExtendedPluginAwareResourceBundleMessageSource) {
        basenames = ["WEB-INF/grails-app/i18n/messages"] as String[]
        cacheSeconds = (60 * 60 * 6) // 6 hours
        useCodeAsDefaultMessage = false
    }
    localeResolver(SessionLocaleResolver) {
        defaultLocale= new java.util.Locale('ca');
    }
}

// Place your Spring DSL code here
//beans = {
//}
