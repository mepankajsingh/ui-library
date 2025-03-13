-- Create tables for UI Library Directory

-- Create tags table
CREATE TABLE tags (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  slug VARCHAR(100) NOT NULL UNIQUE,
  description TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create framework table
CREATE TABLE framework (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  slug VARCHAR(100) NOT NULL UNIQUE,
  description TEXT,
  website_url VARCHAR(255),
  github_url VARCHAR(255),
  npm_url VARCHAR(255),
  stars INTEGER DEFAULT 0,
  logo_url VARCHAR(255),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create library table
CREATE TABLE library (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  slug VARCHAR(100) NOT NULL UNIQUE,
  description TEXT,
  website_url VARCHAR(255),
  github_url VARCHAR(255),
  npm_url VARCHAR(255),
  stars INTEGER DEFAULT 0,
  logo_url VARCHAR(255),
  framework INTEGER REFERENCES framework(id),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create junction table for framework_tags
CREATE TABLE framework_tags (
  framework_id INTEGER REFERENCES framework(id) ON DELETE CASCADE,
  tag_id INTEGER REFERENCES tags(id) ON DELETE CASCADE,
  PRIMARY KEY (framework_id, tag_id)
);

-- Create junction table for library_tags
CREATE TABLE library_tags (
  library_id INTEGER REFERENCES library(id) ON DELETE CASCADE,
  tag_id INTEGER REFERENCES tags(id) ON DELETE CASCADE,
  PRIMARY KEY (library_id, tag_id)
);

-- Create RLS policies
ALTER TABLE tags ENABLE ROW LEVEL SECURITY;
ALTER TABLE framework ENABLE ROW LEVEL SECURITY;
ALTER TABLE library ENABLE ROW LEVEL SECURITY;
ALTER TABLE framework_tags ENABLE ROW LEVEL SECURITY;
ALTER TABLE library_tags ENABLE ROW LEVEL SECURITY;

-- Create policies for public read access
CREATE POLICY "Allow public read access for tags" ON tags
  FOR SELECT USING (true);

CREATE POLICY "Allow public read access for frameworks" ON framework
  FOR SELECT USING (true);

CREATE POLICY "Allow public read access for libraries" ON library
  FOR SELECT USING (true);

CREATE POLICY "Allow public read access for framework_tags" ON framework_tags
  FOR SELECT USING (true);

CREATE POLICY "Allow public read access for library_tags" ON library_tags
  FOR SELECT USING (true);

-- Create functions for easier querying of relationships

-- Function to get tags for a framework
CREATE OR REPLACE FUNCTION get_framework_tags(framework_id INTEGER)
RETURNS SETOF tags AS $$
  SELECT t.*
  FROM tags t
  JOIN framework_tags ft ON t.id = ft.tag_id
  WHERE ft.framework_id = $1;
$$ LANGUAGE SQL STABLE;

-- Function to get tags for a library
CREATE OR REPLACE FUNCTION get_library_tags(library_id INTEGER)
RETURNS SETOF tags AS $$
  SELECT t.*
  FROM tags t
  JOIN library_tags lt ON t.id = lt.tag_id
  WHERE lt.library_id = $1;
$$ LANGUAGE SQL STABLE;

-- Insert some sample data

-- Sample tags
INSERT INTO tags (name, slug, description) VALUES
('UI Components', 'ui-components', 'Libraries that provide ready-to-use UI components'),
('Styling', 'styling', 'Libraries for styling and theming'),
('Animation', 'animation', 'Libraries for animations and transitions'),
('Form Handling', 'form-handling', 'Libraries for form validation and handling'),
('State Management', 'state-management', 'Libraries for managing application state'),
('Routing', 'routing', 'Libraries for handling navigation and routing'),
('Data Visualization', 'data-visualization', 'Libraries for charts and data visualization'),
('Accessibility', 'accessibility', 'Libraries with strong accessibility support'),
('Mobile', 'mobile', 'Libraries optimized for mobile development'),
('Testing', 'testing', 'Libraries for testing UI components');

-- Sample frameworks
INSERT INTO framework (name, slug, description, website_url, github_url, npm_url, stars, logo_url) VALUES
('React', 'react', 'A JavaScript library for building user interfaces', 'https://reactjs.org', 'https://github.com/facebook/react', 'https://www.npmjs.com/package/react', 200000, 'https://upload.wikimedia.org/wikipedia/commons/a/a7/React-icon.svg'),
('Vue.js', 'vue', 'The Progressive JavaScript Framework', 'https://vuejs.org', 'https://github.com/vuejs/vue', 'https://www.npmjs.com/package/vue', 200000, 'https://upload.wikimedia.org/wikipedia/commons/9/95/Vue.js_Logo_2.svg'),
('Angular', 'angular', 'Platform for building mobile and desktop web applications', 'https://angular.io', 'https://github.com/angular/angular', 'https://www.npmjs.com/package/@angular/core', 85000, 'https://upload.wikimedia.org/wikipedia/commons/c/cf/Angular_full_color_logo.svg'),
('Svelte', 'svelte', 'Cybernetically enhanced web apps', 'https://svelte.dev', 'https://github.com/sveltejs/svelte', 'https://www.npmjs.com/package/svelte', 65000, 'https://upload.wikimedia.org/wikipedia/commons/1/1b/Svelte_Logo.svg');

-- Sample libraries
INSERT INTO library (name, slug, description, website_url, github_url, npm_url, stars, logo_url, framework) VALUES
('Material-UI', 'material-ui', 'React components for faster and easier web development', 'https://mui.com', 'https://github.com/mui/material-ui', 'https://www.npmjs.com/package/@mui/material', 80000, 'https://mui.com/static/logo.png', 1),
('Chakra UI', 'chakra-ui', 'Simple, modular and accessible component library for React', 'https://chakra-ui.com', 'https://github.com/chakra-ui/chakra-ui', 'https://www.npmjs.com/package/@chakra-ui/react', 30000, 'https://raw.githubusercontent.com/chakra-ui/chakra-ui/main/logo/logo-colored@2x.png', 1),
('Vuetify', 'vuetify', 'Material Design component framework for Vue.js', 'https://vuetifyjs.com', 'https://github.com/vuetifyjs/vuetify', 'https://www.npmjs.com/package/vuetify', 35000, 'https://cdn.vuetifyjs.com/images/logos/vuetify-logo-dark.png', 2),
('PrimeVue', 'primevue', 'A complete UI Component Library for Vue', 'https://www.primefaces.org/primevue', 'https://github.com/primefaces/primevue', 'https://www.npmjs.com/package/primevue', 3500, 'https://www.primefaces.org/wp-content/uploads/2019/12/primevue-logo.png', 2),
('Angular Material', 'angular-material', 'Material Design components for Angular', 'https://material.angular.io', 'https://github.com/angular/components', 'https://www.npmjs.com/package/@angular/material', 22000, 'https://material.angular.io/assets/img/angular-material-logo.svg', 3),
('PrimeNG', 'primeng', 'UI Component Library for Angular', 'https://www.primefaces.org/primeng', 'https://github.com/primefaces/primeng', 'https://www.npmjs.com/package/primeng', 7500, 'https://www.primefaces.org/wp-content/uploads/2018/05/primeng-logo.png', 3),
('Svelte Material UI', 'svelte-material-ui', 'Svelte Material UI Components', 'https://sveltematerialui.com', 'https://github.com/hperrin/svelte-material-ui', 'https://www.npmjs.com/package/svelte-material-ui', 2500, 'https://raw.githubusercontent.com/hperrin/svelte-material-ui/master/logo.png', 4),
('Carbon Components Svelte', 'carbon-components-svelte', 'Svelte implementation of the Carbon Design System', 'https://carbon-components-svelte.onrender.com', 'https://github.com/carbon-design-system/carbon-components-svelte', 'https://www.npmjs.com/package/carbon-components-svelte', 1500, 'https://github.com/carbon-design-system.png', 4);

-- Connect frameworks with tags
INSERT INTO framework_tags (framework_id, tag_id) VALUES
(1, 1), -- React - UI Components
(1, 5), -- React - State Management
(2, 1), -- Vue - UI Components
(2, 5), -- Vue - State Management
(3, 1), -- Angular - UI Components
(3, 5), -- Angular - State Management
(4, 1), -- Svelte - UI Components
(4, 5); -- Svelte - State Management

-- Connect libraries with tags
INSERT INTO library_tags (library_id, tag_id) VALUES
(1, 1), -- Material-UI - UI Components
(1, 2), -- Material-UI - Styling
(1, 8), -- Material-UI - Accessibility
(2, 1), -- Chakra UI - UI Components
(2, 2), -- Chakra UI - Styling
(2, 8), -- Chakra UI - Accessibility
(3, 1), -- Vuetify - UI Components
(3, 2), -- Vuetify - Styling
(4, 1), -- PrimeVue - UI Components
(4, 7), -- PrimeVue - Data Visualization
(5, 1), -- Angular Material - UI Components
(5, 2), -- Angular Material - Styling
(5, 8), -- Angular Material - Accessibility
(6, 1), -- PrimeNG - UI Components
(6, 7), -- PrimeNG - Data Visualization
(7, 1), -- Svelte Material UI - UI Components
(7, 2), -- Svelte Material UI - Styling
(8, 1), -- Carbon Components Svelte - UI Components
(8, 2); -- Carbon Components Svelte - Styling
