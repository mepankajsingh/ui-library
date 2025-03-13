import { serverSupabaseClient } from '#supabase/server'

export default defineEventHandler(async (event) => {
  const client = await serverSupabaseClient(event)
  const slug = event.context.params?.slug
  
  if (!slug) {
    throw createError({
      statusCode: 400,
      statusMessage: 'Tag slug is required'
    })
  }
  
  // First get the tag ID
  const { data: tag, error: tagError } = await client
    .from('tags')
    .select('id')
    .eq('slug', slug)
    .single()
  
  if (tagError) {
    throw createError({
      statusCode: tagError.code === 'PGRST116' ? 404 : 500,
      statusMessage: tagError.code === 'PGRST116' ? 'Tag not found' : tagError.message
    })
  }
  
  // Then get frameworks with this tag
  const { data: frameworks, error: frameworksError } = await client
    .from('framework')
    .select(`
      *,
      tags:framework_tags(tag_id(id, name, slug, description))
    `)
    .eq('framework_tags.tag_id', tag.id)
  
  if (frameworksError) {
    throw createError({
      statusCode: 500,
      statusMessage: frameworksError.message
    })
  }
  
  return frameworks
})
