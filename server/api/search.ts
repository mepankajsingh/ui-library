import { serverSupabaseClient } from '#supabase/server'

export default defineEventHandler(async (event) => {
  const client = await serverSupabaseClient(event)
  const { q } = getQuery(event)
  
  if (!q) {
    throw createError({
      statusCode: 400,
      statusMessage: 'Search query is required'
    })
  }
  
  const query = String(q)
  
  // Search libraries
  const { data: libraries, error: librariesError } = await client
    .from('library')
    .select(`
      *,
      framework:framework(id, name, slug),
      tags:library_tags(tag_id(id, name, slug, description))
    `)
    .or(`name.ilike.%${query}%,description.ilike.%${query}%`)
  
  if (librariesError) {
    throw createError({
      statusCode: 500,
      statusMessage: librariesError.message
    })
  }
  
  // Search frameworks
  const { data: frameworks, error: frameworksError } = await client
    .from('framework')
    .select(`
      *,
      tags:framework_tags(tag_id(id, name, slug, description))
    `)
    .or(`name.ilike.%${query}%,description.ilike.%${query}%`)
  
  if (frameworksError) {
    throw createError({
      statusCode: 500,
      statusMessage: frameworksError.message
    })
  }
  
  return {
    libraries: libraries || [],
    frameworks: frameworks || []
  }
})
