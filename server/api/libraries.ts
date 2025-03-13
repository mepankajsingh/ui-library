import { serverSupabaseClient } from '#supabase/server'

export default defineEventHandler(async (event) => {
  const client = await serverSupabaseClient(event)
  
  const { frameworkId } = getQuery(event)
  
  let query = client
    .from('library')
    .select(`
      *,
      framework:framework(id, name, slug),
      tags:library_tags(tag_id(id, name, slug, description))
    `)
  
  if (frameworkId) {
    query = query.eq('framework', frameworkId)
  }
  
  const { data, error } = await query
  
  if (error) {
    throw createError({
      statusCode: 500,
      statusMessage: error.message
    })
  }
  
  return data
})
